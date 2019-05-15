#!/usr/bin/env python
# coding=utf8
# Nerd Fonts Version: 2.0.0
# script version: 2.0.1

from __future__ import absolute_import, print_function, unicode_literals

version = "2.0.0"
projectName = "Nerd Fonts"
projectNameAbbreviation = "NF"
projectNameSingular = projectName[:-1]

import sys

try:
    import psMat
except ImportError:
    sys.exit(projectName + ": FontForge module is probably not installed. [See: http://designwithfontforge.com/en-US/Installing_Fontforge.html]")

import re
import os
import argparse
from argparse import RawTextHelpFormatter
import errno
import subprocess
import json

"""Configuration file parser.

A setup file consists of sections, lead by a "[section]" header,
and followed by "name: value" entries, with continuations and such in
the style of RFC 822.

The option values can contain format strings which refer to other values in
the same section, or values in a special [DEFAULT] section.

For example:

    something: %(dir)s/whatever

would resolve the "%(dir)s" to the value of dir.  All reference
expansions are done late, on demand.

Intrinsic defaults can be specified by passing them into the
ConfigParser constructor as a dictionary.

class:

ConfigParser -- responsible for parsing a list of
                configuration files, and managing the parsed database.

    methods:

    __init__(defaults=None)
        create the parser and specify a dictionary of intrinsic defaults.  The
        keys must be strings, the values must be appropriate for %()s string
        interpolation.  Note that `__name__' is always an intrinsic default;
        its value is the section's name.

    sections()
        return all the configuration section names, sans DEFAULT

    has_section(section)
        return whether the given section exists

    has_option(section, option)
        return whether the given option exists in the given section

    options(section)
        return list of configuration options for the named section

    read(filenames)
        read and parse the list of named configuration files, given by
        name.  A single filename is also allowed.  Non-existing files
        are ignored.  Return list of successfully read files.

    readfp(fp, filename=None)
        read and parse one configuration file, given as a file object.
        The filename defaults to fp.name; it is only used in error
        messages (if fp has no `name' attribute, the string `<???>' is used).

    get(section, option, raw=False, vars=None)
        return a string value for the named option.  All % interpolations are
        expanded in the return values, based on the defaults passed into the
        constructor and the DEFAULT section.  Additional substitutions may be
        provided using the `vars' argument, which must be a dictionary whose
        contents override any pre-existing defaults.

    getint(section, options)
        like get(), but convert value to an integer

    getfloat(section, options)
        like get(), but convert value to a float

    getboolean(section, options)
        like get(), but convert value to a boolean (currently case
        insensitively defined as 0, false, no, off for False, and 1, true,
        yes, on for True).  Returns False or True.

    items(section, raw=False, vars=None)
        return a list of tuples with (name, value) for each option
        in the section.

    remove_section(section)
        remove the given file section and all its options

    remove_option(section, option)
        remove the given option from the given section

    set(section, option, value)
        set the given option

    write(fp)
        write the configuration state in .ini format
"""

try:
    from collections import OrderedDict as _default_dict
except ImportError:
    # fallback for setup.py which hasn't yet built _collections
    _default_dict = dict

import re

__all__ = ["NoSectionError", "DuplicateSectionError", "NoOptionError",
           "InterpolationError", "InterpolationDepthError",
           "InterpolationSyntaxError", "ParsingError",
           "MissingSectionHeaderError",
           "ConfigParser", "SafeConfigParser", "RawConfigParser",
           "DEFAULTSECT", "MAX_INTERPOLATION_DEPTH"]

DEFAULTSECT = "DEFAULT"

MAX_INTERPOLATION_DEPTH = 10



# exception classes
class Error(Exception):
    """Base class for ConfigParser exceptions."""

    def _get_message(self):
        """Getter for 'message'; needed only to override deprecation in
        BaseException."""
        return self.__message

    def _set_message(self, value):
        """Setter for 'message'; needed only to override deprecation in
        BaseException."""
        self.__message = value

    # BaseException.message has been deprecated since Python 2.6.  To prevent
    # DeprecationWarning from popping up over this pre-existing attribute, use
    # a new property that takes lookup precedence.
    message = property(_get_message, _set_message)

    def __init__(self, msg=''):
        self.message = msg
        Exception.__init__(self, msg)

    def __repr__(self):
        return self.message

    __str__ = __repr__

class NoSectionError(Error):
    """Raised when no section matches a requested option."""

    def __init__(self, section):
        Error.__init__(self, 'No section: %r' % (section,))
        self.section = section
        self.args = (section, )

class DuplicateSectionError(Error):
    """Raised when a section is multiply-created."""

    def __init__(self, section):
        Error.__init__(self, "Section %r already exists" % section)
        self.section = section
        self.args = (section, )

class NoOptionError(Error):
    """A requested option was not found."""

    def __init__(self, option, section):
        Error.__init__(self, "No option %r in section: %r" %
                       (option, section))
        self.option = option
        self.section = section
        self.args = (option, section)

class InterpolationError(Error):
    """Base class for interpolation-related exceptions."""

    def __init__(self, option, section, msg):
        Error.__init__(self, msg)
        self.option = option
        self.section = section
        self.args = (option, section, msg)

class InterpolationMissingOptionError(InterpolationError):
    """A string substitution required a setting which was not available."""

    def __init__(self, option, section, rawval, reference):
        msg = ("Bad value substitution:\n"
               "\tsection: [%s]\n"
               "\toption : %s\n"
               "\tkey    : %s\n"
               "\trawval : %s\n"
               % (section, option, reference, rawval))
        InterpolationError.__init__(self, option, section, msg)
        self.reference = reference
        self.args = (option, section, rawval, reference)

class InterpolationSyntaxError(InterpolationError):
    """Raised when the source text into which substitutions are made
    does not conform to the required syntax."""

class InterpolationDepthError(InterpolationError):
    """Raised when substitutions are nested too deeply."""

    def __init__(self, option, section, rawval):
        msg = ("Value interpolation too deeply recursive:\n"
               "\tsection: [%s]\n"
               "\toption : %s\n"
               "\trawval : %s\n"
               % (section, option, rawval))
        InterpolationError.__init__(self, option, section, msg)
        self.args = (option, section, rawval)

class ParsingError(Error):
    """Raised when a configuration file does not follow legal syntax."""

    def __init__(self, filename):
        Error.__init__(self, 'File contains parsing errors: %s' % filename)
        self.filename = filename
        self.errors = []
        self.args = (filename, )

    def append(self, lineno, line):
        self.errors.append((lineno, line))
        self.message += '\n\t[line %2d]: %s' % (lineno, line)

class MissingSectionHeaderError(ParsingError):
    """Raised when a key-value pair is found before any section header."""

    def __init__(self, filename, lineno, line):
        Error.__init__(
            self,
            'File contains no section headers.\nfile: %s, line: %d\n%r' %
            (filename, lineno, line))
        self.filename = filename
        self.lineno = lineno
        self.line = line
        self.args = (filename, lineno, line)


class RawConfigParser:
    def __init__(self, defaults=None, dict_type=_default_dict,
                 allow_no_value=False):
        self._dict = dict_type
        self._sections = self._dict()
        self._defaults = self._dict()
        if allow_no_value:
            self._optcre = self.OPTCRE_NV
        else:
            self._optcre = self.OPTCRE
        if defaults:
            for key, value in defaults.items():
                self._defaults[self.optionxform(key)] = value

    def defaults(self):
        return self._defaults

    def sections(self):
        """Return a list of section names, excluding [DEFAULT]"""
        # self._sections will never have [DEFAULT] in it
        return self._sections.keys()

    def add_section(self, section):
        """Create a new section in the configuration.

        Raise DuplicateSectionError if a section by the specified name
        already exists. Raise ValueError if name is DEFAULT or any of it's
        case-insensitive variants.
        """
        if section.lower() == "default":
            raise ValueError, 'Invalid section name: %s' % section

        if section in self._sections:
            raise DuplicateSectionError(section)
        self._sections[section] = self._dict()

    def has_section(self, section):
        """Indicate whether the named section is present in the configuration.

        The DEFAULT section is not acknowledged.
        """
        return section in self._sections

    def options(self, section):
        """Return a list of option names for the given section name."""
        try:
            opts = self._sections[section].copy()
        except KeyError:
            raise NoSectionError(section)
        opts.update(self._defaults)
        if '__name__' in opts:
            del opts['__name__']
        return opts.keys()

    def read(self, filenames):
        """Read and parse a filename or a list of filenames.

        Files that cannot be opened are silently ignored; this is
        designed so that you can specify a list of potential
        configuration file locations (e.g. current directory, user's
        home directory, systemwide directory), and all existing
        configuration files in the list will be read.  A single
        filename may also be given.

        Return list of successfully read files.
        """
        if isinstance(filenames, basestring):
            filenames = [filenames]
        read_ok = []
        for filename in filenames:
            try:
                fp = open(filename)
            except IOError:
                continue
            self._read(fp, filename)
            fp.close()
            read_ok.append(filename)
        return read_ok

    def readfp(self, fp, filename=None):
        """Like read() but the argument must be a file-like object.

        The `fp' argument must have a `readline' method.  Optional
        second argument is the `filename', which if not given, is
        taken from fp.name.  If fp has no `name' attribute, `<???>' is
        used.

        """
        if filename is None:
            try:
                filename = fp.name
            except AttributeError:
                filename = '<???>'
        self._read(fp, filename)

    def get(self, section, option):
        opt = self.optionxform(option)
        if section not in self._sections:
            if section != DEFAULTSECT:
                raise NoSectionError(section)
            if opt in self._defaults:
                return self._defaults[opt]
            else:
                raise NoOptionError(option, section)
        elif opt in self._sections[section]:
            return self._sections[section][opt]
        elif opt in self._defaults:
            return self._defaults[opt]
        else:
            raise NoOptionError(option, section)

    def items(self, section):
        try:
            d2 = self._sections[section]
        except KeyError:
            if section != DEFAULTSECT:
                raise NoSectionError(section)
            d2 = self._dict()
        d = self._defaults.copy()
        d.update(d2)
        if "__name__" in d:
            del d["__name__"]
        return d.items()

    def _get(self, section, conv, option):
        return conv(self.get(section, option))

    def getint(self, section, option):
        return self._get(section, int, option)

    def getfloat(self, section, option):
        return self._get(section, float, option)

    _boolean_states = {'1': True, 'yes': True, 'true': True, 'on': True,
                       '0': False, 'no': False, 'false': False, 'off': False}

    def getboolean(self, section, option):
        v = self.get(section, option)
        if v.lower() not in self._boolean_states:
            raise ValueError, 'Not a boolean: %s' % v
        return self._boolean_states[v.lower()]

    def optionxform(self, optionstr):
        return optionstr.lower()

    def has_option(self, section, option):
        """Check for the existence of a given option in a given section."""
        if not section or section == DEFAULTSECT:
            option = self.optionxform(option)
            return option in self._defaults
        elif section not in self._sections:
            return False
        else:
            option = self.optionxform(option)
            return (option in self._sections[section]
                    or option in self._defaults)

    def set(self, section, option, value=None):
        """Set an option."""
        if not section or section == DEFAULTSECT:
            sectdict = self._defaults
        else:
            try:
                sectdict = self._sections[section]
            except KeyError:
                raise NoSectionError(section)
        sectdict[self.optionxform(option)] = value

    def write(self, fp):
        """Write an .ini-format representation of the configuration state."""
        if self._defaults:
            fp.write("[%s]\n" % DEFAULTSECT)
            for (key, value) in self._defaults.items():
                fp.write("%s = %s\n" % (key, str(value).replace('\n', '\n\t')))
            fp.write("\n")
        for section in self._sections:
            fp.write("[%s]\n" % section)
            for (key, value) in self._sections[section].items():
                if key == "__name__":
                    continue
                if (value is not None) or (self._optcre == self.OPTCRE):
                    key = " = ".join((key, str(value).replace('\n', '\n\t')))
                fp.write("%s\n" % (key))
            fp.write("\n")

    def remove_option(self, section, option):
        """Remove an option."""
        if not section or section == DEFAULTSECT:
            sectdict = self._defaults
        else:
            try:
                sectdict = self._sections[section]
            except KeyError:
                raise NoSectionError(section)
        option = self.optionxform(option)
        existed = option in sectdict
        if existed:
            del sectdict[option]
        return existed

    def remove_section(self, section):
        """Remove a file section."""
        existed = section in self._sections
        if existed:
            del self._sections[section]
        return existed

    #
    # Regular expressions for parsing section headers and options.
    #
    SECTCRE = re.compile(
        r'\['                                 # [
        r'(?P<header>[^]]+)'                  # very permissive!
        r'\]'                                 # ]
        )
    OPTCRE = re.compile(
        r'(?P<option>[^:=\s][^:=]*)'          # very permissive!
        r'\s*(?P<vi>[:=])\s*'                 # any number of space/tab,
                                              # followed by separator
                                              # (either : or =), followed
                                              # by any # space/tab
        r'(?P<value>.*)$'                     # everything up to eol
        )
    OPTCRE_NV = re.compile(
        r'(?P<option>[^:=\s][^:=]*)'          # very permissive!
        r'\s*(?:'                             # any number of space/tab,
        r'(?P<vi>[:=])\s*'                    # optionally followed by
                                              # separator (either : or
                                              # =), followed by any #
                                              # space/tab
        r'(?P<value>.*))?$'                   # everything up to eol
        )

    def _read(self, fp, fpname):
        """Parse a sectioned setup file.

        The sections in setup file contains a title line at the top,
        indicated by a name in square brackets (`[]'), plus key/value
        options lines, indicated by `name: value' format lines.
        Continuations are represented by an embedded newline then
        leading whitespace.  Blank lines, lines beginning with a '#',
        and just about everything else are ignored.
        """
        cursect = None                        # None, or a dictionary
        optname = None
        lineno = 0
        e = None                              # None, or an exception
        while True:
            line = fp.readline()
            if not line:
                break
            lineno = lineno + 1
            # comment or blank line?
            if line.strip() == '' or line[0] in '#;':
                continue
            if line.split(None, 1)[0].lower() == 'rem' and line[0] in "rR":
                # no leading whitespace
                continue
            # continuation line?
            if line[0].isspace() and cursect is not None and optname:
                value = line.strip()
                if value:
                    cursect[optname].append(value)
            # a section header or option header?
            else:
                # is it a section header?
                mo = self.SECTCRE.match(line)
                if mo:
                    sectname = mo.group('header')
                    if sectname in self._sections:
                        cursect = self._sections[sectname]
                    elif sectname == DEFAULTSECT:
                        cursect = self._defaults
                    else:
                        cursect = self._dict()
                        cursect['__name__'] = sectname
                        self._sections[sectname] = cursect
                    # So sections can't start with a continuation line
                    optname = None
                # no section header in the file?
                elif cursect is None:
                    raise MissingSectionHeaderError(fpname, lineno, line)
                # an option line?
                else:
                    mo = self._optcre.match(line)
                    if mo:
                        optname, vi, optval = mo.group('option', 'vi', 'value')
                        optname = self.optionxform(optname.rstrip())
                        # This check is fine because the OPTCRE cannot
                        # match if it would set optval to None
                        if optval is not None:
                            if vi in ('=', ':') and ';' in optval:
                                # ';' is a comment delimiter only if it follows
                                # a spacing character
                                pos = optval.find(';')
                                if pos != -1 and optval[pos-1].isspace():
                                    optval = optval[:pos]
                            optval = optval.strip()
                            # allow empty values
                            if optval == '""':
                                optval = ''
                            cursect[optname] = [optval]
                        else:
                            # valueless option handling
                            cursect[optname] = optval
                    else:
                        # a non-fatal parsing error occurred.  set up the
                        # exception but keep going. the exception will be
                        # raised at the end of the file and will contain a
                        # list of all bogus lines
                        if not e:
                            e = ParsingError(fpname)
                        e.append(lineno, repr(line))
        # if any parsing errors occurred, raise an exception
        if e:
            raise e

        # join the multi-line values collected while reading
        all_sections = [self._defaults]
        all_sections.extend(self._sections.values())
        for options in all_sections:
            for name, val in options.items():
                if isinstance(val, list):
                    options[name] = '\n'.join(val)

import UserDict as _UserDict

class _Chainmap(_UserDict.DictMixin):
    """Combine multiple mappings for successive lookups.

    For example, to emulate Python's normal lookup sequence:

        import __builtin__
        pylookup = _Chainmap(locals(), globals(), vars(__builtin__))
    """

    def __init__(self, *maps):
        self._maps = maps

    def __getitem__(self, key):
        for mapping in self._maps:
            try:
                return mapping[key]
            except KeyError:
                pass
        raise KeyError(key)

    def keys(self):
        result = []
        seen = set()
        for mapping in self._maps:
            for key in mapping:
                if key not in seen:
                    result.append(key)
                    seen.add(key)
        return result

class ConfigParser(RawConfigParser):

    def get(self, section, option, raw=False, vars=None):
        """Get an option value for a given section.

        If `vars' is provided, it must be a dictionary. The option is looked up
        in `vars' (if provided), `section', and in `defaults' in that order.

        All % interpolations are expanded in the return values, unless the
        optional argument `raw' is true. Values for interpolation keys are
        looked up in the same manner as the option.

        The section DEFAULT is special.
        """
        sectiondict = {}
        try:
            sectiondict = self._sections[section]
        except KeyError:
            if section != DEFAULTSECT:
                raise NoSectionError(section)
        # Update with the entry specific variables
        vardict = {}
        if vars:
            for key, value in vars.items():
                vardict[self.optionxform(key)] = value
        d = _Chainmap(vardict, sectiondict, self._defaults)
        option = self.optionxform(option)
        try:
            value = d[option]
        except KeyError:
            raise NoOptionError(option, section)

        if raw or value is None:
            return value
        else:
            return self._interpolate(section, option, value, d)

    def items(self, section, raw=False, vars=None):
        """Return a list of tuples with (name, value) for each option
        in the section.

        All % interpolations are expanded in the return values, based on the
        defaults passed into the constructor, unless the optional argument
        `raw' is true.  Additional substitutions may be provided using the
        `vars' argument, which must be a dictionary whose contents overrides
        any pre-existing defaults.

        The section DEFAULT is special.
        """
        d = self._defaults.copy()
        try:
            d.update(self._sections[section])
        except KeyError:
            if section != DEFAULTSECT:
                raise NoSectionError(section)
        # Update with the entry specific variables
        if vars:
            for key, value in vars.items():
                d[self.optionxform(key)] = value
        options = d.keys()
        if "__name__" in options:
            options.remove("__name__")
        if raw:
            return [(option, d[option])
                    for option in options]
        else:
            return [(option, self._interpolate(section, option, d[option], d))
                    for option in options]

    def _interpolate(self, section, option, rawval, vars):
        # do the string interpolation
        value = rawval
        depth = MAX_INTERPOLATION_DEPTH
        while depth:                    # Loop through this until it's done
            depth -= 1
            if value and "%(" in value:
                value = self._KEYCRE.sub(self._interpolation_replace, value)
                try:
                    value = value % vars
                except KeyError, e:
                    raise InterpolationMissingOptionError(
                        option, section, rawval, e.args[0])
            else:
                break
        if value and "%(" in value:
            raise InterpolationDepthError(option, section, rawval)
        return value

    _KEYCRE = re.compile(r"%\(([^)]*)\)s|.")

    def _interpolation_replace(self, match):
        s = match.group(1)
        if s is None:
            return match.group()
        else:
            return "%%(%s)s" % self.optionxform(s)


class SafeConfigParser(ConfigParser):

    def _interpolate(self, section, option, rawval, vars):
        # do the string interpolation
        L = []
        self._interpolate_some(option, L, rawval, section, vars, 1)
        return ''.join(L)

    _interpvar_re = re.compile(r"%\(([^)]+)\)s")

    def _interpolate_some(self, option, accum, rest, section, map, depth):
        if depth > MAX_INTERPOLATION_DEPTH:
            raise InterpolationDepthError(option, section, rest)
        while rest:
            p = rest.find("%")
            if p < 0:
                accum.append(rest)
                return
            if p > 0:
                accum.append(rest[:p])
                rest = rest[p:]
            # p is no longer used
            c = rest[1:2]
            if c == "%":
                accum.append("%")
                rest = rest[2:]
            elif c == "(":
                m = self._interpvar_re.match(rest)
                if m is None:
                    raise InterpolationSyntaxError(option, section,
                        "bad interpolation variable reference %r" % rest)
                var = self.optionxform(m.group(1))
                rest = rest[m.end():]
                try:
                    v = map[var]
                except KeyError:
                    raise InterpolationMissingOptionError(
                        option, section, rest, var)
                if "%" in v:
                    self._interpolate_some(option, accum, v,
                                           section, map, depth + 1)
                else:
                    accum.append(v)
            else:
                raise InterpolationSyntaxError(
                    option, section,
                    "'%%' must be followed by '%%' or '(', found: %r" % (rest,))

    def set(self, section, option, value=None):
        """Set an option.  Extend ConfigParser.set: check for string values."""
        # The only legal non-string value if we allow valueless
        # options is None, so we need to check if the value is a
        # string if:
        # - we do not allow valueless options, or
        # - we allow valueless options but the value is not None
        if self._optcre is self.OPTCRE or value:
            if not isinstance(value, basestring):
                raise TypeError("option values must be strings")
        if value is not None:
            # check for bad percent signs:
            # first, replace all "good" interpolations
            tmp_value = value.replace('%%', '')
            tmp_value = self._interpvar_re.sub('', tmp_value)
            # then, check if there's a lone percent sign left
            if '%' in tmp_value:
                raise ValueError("invalid interpolation syntax in %r at "
                                "position %d" % (value, tmp_value.find('%')))
        ConfigParser.set(self, section, option, value)


try:
    #Load the module
    import fontforge

except ImportError:
    sys.exit(projectName + ": FontForge module could not be loaded. Try installing fontforge python bindings [e.g. on Linux Debian or Ubuntu: `sudo apt install fontforge python-fontforge`]")

# argparse stuff

parser = argparse.ArgumentParser(description='Nerd Fonts Font Patcher: patches a given font with programming and development related glyphs\n\n* Website: https://www.nerdfonts.com\n* Version: ' + version + '\n* Development Website: https://github.com/ryanoasis/nerd-fonts\n* Changelog: https://github.com/ryanoasis/nerd-fonts/blob/master/changelog.md', formatter_class=RawTextHelpFormatter)
parser.add_argument('-v', '--version', action='version', version=projectName + ": %(prog)s ("+version+")")
parser.add_argument('font', help='The path to the font to patch (e.g., Inconsolata.otf)')
parser.add_argument('-s', '--mono', '--use-single-width-glyphs', dest='single', action='store_true', help='Whether to generate the glyphs as single-width not double-width (default is double-width)', default=False)
parser.add_argument('-l', '--adjust-line-height', dest='adjustLineHeight', action='store_true', help='Whether to adjust line heights (attempt to center powerline separators more evenly)', default=False)
parser.add_argument('-q', '--quiet', '--shutup', dest='quiet', action='store_true', help='Do not generate verbose output', default=False)
parser.add_argument('-w', '--windows', dest='windows', action='store_true', help='Limit the internal font name to 31 characters (for Windows compatibility)', default=False)
parser.add_argument('-c', '--complete', dest='complete', action='store_true', help='Add all available Glyphs', default=False)
parser.add_argument('--fontawesome', dest='fontawesome', action='store_true', help='Add Font Awesome Glyphs (http://fontawesome.io/)', default=False)
parser.add_argument('--fontawesomeextension', dest='fontawesomeextension', action='store_true', help='Add Font Awesome Extension Glyphs (https://andrelzgava.github.io/font-awesome-extension/)', default=False)
parser.add_argument('--fontlinux', '--fontlogos', dest='fontlinux', action='store_true', help='Add Font Linux and other open source Glyphs (https://github.com/Lukas-W/font-logos)', default=False)
parser.add_argument('--octicons', dest='octicons', action='store_true', help='Add Octicons Glyphs (https://octicons.github.com)', default=False)
parser.add_argument('--powersymbols', dest='powersymbols', action='store_true', help='Add IEC Power Symbols (https://unicodepowersymbol.com/)', default=False)
parser.add_argument('--pomicons', dest='pomicons', action='store_true', help='Add Pomicon Glyphs (https://github.com/gabrielelana/pomicons)', default=False)
parser.add_argument('--powerline', dest='powerline', action='store_true', help='Add Powerline Glyphs', default=False)
parser.add_argument('--powerlineextra', dest='powerlineextra', action='store_true', help='Add Powerline Glyphs (https://github.com/ryanoasis/powerline-extra-symbols)', default=False)
parser.add_argument('--material', '--materialdesignicons', '--mdi', dest='material', action='store_true', help='Add Material Design Icons (https://github.com/templarian/MaterialDesign)', default=False)
parser.add_argument('--weather', '--weathericons', dest='weather', action='store_true', help='Add Weather Icons (https://github.com/erikflowers/weather-icons)', default=False)
parser.add_argument('--custom', type=str, nargs='?', dest='custom', help='Specify a custom symbol font. All new glyphs will be copied, with no scaling applied.', default=False)
parser.add_argument('--postprocess', type=str, nargs='?', dest='postprocess', help='Specify a Script for Post Processing', default=False)
parser.add_argument('--removeligs', '--removeligatures', dest='removeligatures', action='store_true', help='Removes ligatures specified in JSON configuration file', default=False)
parser.add_argument('--configfile', type=str, nargs='?', dest='configfile', help='Specify a file path for JSON configuration file (see sample: src/config.sample.json)', default=False)

# https://stackoverflow.com/questions/15008758/parsing-boolean-values-with-argparse
progressbars_group_parser = parser.add_mutually_exclusive_group(required=False)
progressbars_group_parser.add_argument('--progressbars', dest='progressbars', action='store_true', help='Show percentage completion progress bars per Glyph Set')
progressbars_group_parser.add_argument('--no-progressbars', dest='progressbars', action='store_false', help='Don\'t show percentage completion progress bars per Glyph Set')
parser.set_defaults(progressbars=True)

parser.add_argument('--careful', dest='careful', action='store_true', help='Do not overwrite existing glyphs if detected', default=False)
parser.add_argument('-ext', '--extension', type=str, nargs='?', dest='extension', help='Change font file type to create (e.g., ttf, otf)', default="")
parser.add_argument('-out', '--outputdir', type=str, nargs='?', dest='outputdir', help='The directory to output the patched font file to', default=".")
args = parser.parse_args()


config = ConfigParser()

__dir__ = os.path.dirname(os.path.abspath(__file__))
minimumVersion = 20141231
actualVersion = int(fontforge.version())
# un-comment following line for testing invalid version error handling
#actualVersion = 20120731
# versions tested: 20150612, 20150824

if actualVersion < minimumVersion:
    sys.stderr.write("{}: You seem to be using an unsupported (old) version of fontforge: {}\n".format(projectName, actualVersion))
    sys.stderr.write("{}: Please use at least version: {}\n".format(projectName, minimumVersion))
    sys.exit(1)

verboseAdditionalFontNameSuffix = " " + projectNameSingular

if args.complete:
    args.fontawesome = True
    args.fontawesomeextension = True
    args.fontlinux = True
    args.octicons = True
    args.powersymbols = True
    args.pomicons = True
    args.powerline = True
    args.powerlineextra = True
    args.material = True
    args.weather = True

if args.windows:
    # attempt to shorten here on the additional name BEFORE trimming later
    additionalFontNameSuffix = " " + projectNameAbbreviation
else:
    additionalFontNameSuffix = verboseAdditionalFontNameSuffix

if args.fontawesome:
    additionalFontNameSuffix += " A"
    verboseAdditionalFontNameSuffix += " Plus Font Awesome"

if args.fontawesomeextension:
    additionalFontNameSuffix += " AE"
    verboseAdditionalFontNameSuffix += " Plus Font Awesome Extension"

if args.octicons:
    additionalFontNameSuffix += " O"
    verboseAdditionalFontNameSuffix += " Plus Octicons"

if args.powersymbols:
    additionalFontNameSuffix += " PS"
    verboseAdditionalFontNameSuffix += " Plus Power Symbols"

if args.pomicons:
    additionalFontNameSuffix += " P"
    verboseAdditionalFontNameSuffix += " Plus Pomicons"

if args.fontlinux:
    additionalFontNameSuffix += " L"
    verboseAdditionalFontNameSuffix += " Plus Font Logos (Font Linux)"

if args.material:
    additionalFontNameSuffix += " MDI"
    verboseAdditionalFontNameSuffix += " Plus Material Design Icons"

if args.weather:
    additionalFontNameSuffix += " WEA"
    verboseAdditionalFontNameSuffix += " Plus Weather Icons"

# if all source glyphs included simplify the name
if args.fontawesome and args.fontawesomeextension and args.octicons and args.powersymbols and args.pomicons and args.powerlineextra and args.fontlinux and args.material and args.weather:
    additionalFontNameSuffix = " " + projectNameSingular + " Complete"
    verboseAdditionalFontNameSuffix = " " + projectNameSingular + " Complete"

# add mono signifier to end of name
if args.single:
    additionalFontNameSuffix += " M"
    verboseAdditionalFontNameSuffix += " Mono"

sourceFont = fontforge.open(args.font)

# let's deal with ligatures (mostly for monospaced fonts)
if args.configfile and config.read(args.configfile):
  if args.removeligatures:
    print("Removing ligatures from configfile `Subtables` section")
    ligature_subtables = json.loads(config.get("Subtables","ligatures"))
    for subtable in ligature_subtables:
      print("Removing subtable:", subtable)
      try:
        sourceFont.removeLookupSubtable(subtable)
        print("Successfully removed subtable:", subtable)
      except Exception:
        print("Failed to remove subtable:", subtable)
elif args.removeligatures:
  print("Unable to read configfile, unable to remove ligatures")
else:
  print("No configfile given, skipping configfile related actions")

# basically split the font name around the dash "-" to get the fontname and the style (e.g. Bold)
# this does not seem very reliable so only use the style here as a fallback if the font does not
# have an internal style defined (in sfnt_names)
# using '([^-]*?)' to get the item before the first dash "-"
# using '([^-]*(?!.*-))' to get the item after the last dash "-"
fontname, fallbackStyle = re.match("^([^-]*).*?([^-]*(?!.*-))$", sourceFont.fontname).groups()
# dont trust 'sourceFont.familyname'
familyname = fontname
# fullname (filename) can always use long/verbose font name, even in windows
fullname = sourceFont.fullname + verboseAdditionalFontNameSuffix
fontname = fontname + additionalFontNameSuffix.replace(" ", "")

# let us try to get the 'style' from the font info in sfnt_names and fallback to the
# parse fontname if it fails:
try:
    # search tuple:
    subFamilyTupleIndex = [x[1] for x in sourceFont.sfnt_names].index("SubFamily")
    # String ID is at the second index in the Tuple lists
    sfntNamesStringIDIndex = 2
    # now we have the correct item:
    subFamily = sourceFont.sfnt_names[subFamilyTupleIndex][sfntNamesStringIDIndex]
except IndexError:
    sys.stderr.write("{}: Could not find 'SubFamily' for given font, falling back to parsed fontname\n".format(projectName))
    subFamily = fallbackStyle

# some fonts have inaccurate 'SubFamily', if it is Regular let us trust the filename more:
if subFamily == "Regular":
    subFamily = fallbackStyle

if args.windows:
    maxFamilyLength = 31
    maxFontLength = maxFamilyLength-len('-' + subFamily)
    familyname += " " + projectNameAbbreviation
    fullname += " Windows Compatible"
    # now make sure less than 32 characters name length
    if len(fontname) > maxFontLength:
        fontname = fontname[:maxFontLength]
    if len(familyname) > maxFamilyLength:
        familyname = familyname[:maxFamilyLength]
else:
    familyname += " " + projectNameSingular

    if args.single:
        familyname += " Mono"

# Don't truncate the subfamily to keep fontname unique.  MacOS treats fonts with
# the same name as the same font, even if subFamily is different.
fontname += '-' + subFamily

# rename font

def replace_all(text, dic):
    for i, j in dic.items():
        text = text.replace(i, j)
    return text


def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise

make_sure_path_exists(args.outputdir)

# comply with SIL Open Font License (OFL)
reservedFontNameReplacements = {
    'source'  : 'sauce',
    'Source'  : 'Sauce',
    'hermit'  : 'hurmit',
    'Hermit'  : 'Hurmit',
    'fira'    : 'fura',
    'Fira'    : 'Fura',
    'hasklig' : 'hasklug',
    'Hasklig' : 'Hasklug',
    'Share'   : 'Shure',
    'share'   : 'shure',
    'IBMPlex' : 'Blex',
    'ibmplex' : 'blex',
    'IBM-Plex': 'Blex',
    'IBM Plex': 'Blex',
    'terminus': 'terminess',
    'Terminus': 'Terminess'
}

# remove overly verbose font names
# particularly regarding Powerline sourced Fonts (https://github.com/powerline/fonts)
additionalFontNameReplacements = {
    'for Powerline' : '',
    'ForPowerline' : ''
}
additionalFontNameReplacements2 = {
    'Powerline'     : ''
}

projectInfo = "Patched with '" + projectName + " Patcher' (https://github.com/ryanoasis/nerd-fonts)\n\n* Website: https://www.nerdfonts.com\n* Version: " + version + "\n* Development Website: https://github.com/ryanoasis/nerd-fonts\n* Changelog: https://github.com/ryanoasis/nerd-fonts/blob/master/changelog.md"

familyname = replace_all(familyname, reservedFontNameReplacements)
fullname = replace_all(fullname, reservedFontNameReplacements)
fontname = replace_all(fontname, reservedFontNameReplacements)
familyname = replace_all(familyname, additionalFontNameReplacements)
fullname = replace_all(fullname, additionalFontNameReplacements)
fontname = replace_all(fontname, additionalFontNameReplacements)
familyname = replace_all(familyname, additionalFontNameReplacements2)
fullname = replace_all(fullname, additionalFontNameReplacements2)
fontname = replace_all(fontname, additionalFontNameReplacements2)

# replace any extra whitespace characters:
familyname = " ".join(familyname.split())
fullname = " ".join(fullname.split())
fontname = " ".join(fontname.split())

sourceFont.familyname = familyname
sourceFont.fullname = fullname
sourceFont.fontname = fontname

sourceFont.appendSFNTName(str('English (US)'), str('Preferred Family'), sourceFont.familyname)
sourceFont.appendSFNTName(str('English (US)'), str('Family'), sourceFont.familyname)
sourceFont.appendSFNTName(str('English (US)'), str('Compatible Full'), sourceFont.fullname)
sourceFont.appendSFNTName(str('English (US)'), str('SubFamily'), subFamily)
sourceFont.comment = projectInfo
sourceFont.fontlog = projectInfo

# todo version not being set for all font types (e.g. ttf)
#print("Version was {}".format(sourceFont.version))
sourceFont.version += ";" + projectName + " " + version
#print("Version now is {}".format(sourceFont.version))

# Prevent glyph encoding position conflicts between glyph sets

octiconsExactEncodingPosition = True
if args.fontawesome and args.octicons:
    octiconsExactEncodingPosition = False

fontlinuxExactEncodingPosition = True
if args.fontawesome or args.octicons:
    fontlinuxExactEncodingPosition = False

# Supported params: overlap | careful

# Powerline dividers
SYM_ATTR_POWERLINE = {
    'default': { 'align': 'c', 'valign': 'c', 'stretch': 'pa', 'params': '' },

    # Arrow tips
    0xe0b0: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0b1: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0b2: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0b3: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },

    # Rounded arcs
    0xe0b4: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0b5: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0b6: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0b7: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },

    # Bottom Triangles
    0xe0b8: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0b9: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0ba: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0bb: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },

    # Top Triangles
    0xe0bc: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0bd: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0be: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0bf: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },

    # Flames
    0xe0c0: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0c1: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0c2: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },
    0xe0c3: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },

    # Small squares
    0xe0c4: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': '' },
    0xe0c5: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': '' },

    # Bigger squares
    0xe0c6: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': '' },
    0xe0c7: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': '' },

    # Waveform
    0xe0c8: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.01} },

    # Hexagons
    0xe0cc: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': '' },
    0xe0cd: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': '' },

    # Legos
    0xe0ce: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': '' },
    0xe0cf: { 'align': 'c', 'valign': 'c', 'stretch': 'xy', 'params': '' },
    0xe0d1: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },

    # Top and bottom trapezoid
    0xe0d2: { 'align': 'l', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
    0xe0d4: { 'align': 'r', 'valign': 'c', 'stretch': 'xy', 'params': {'overlap':0.02} },
}

SYM_ATTR_DEFAULT = {
    # 'pa' == preserve aspect ratio
    'default': { 'align': 'c', 'valign': 'c', 'stretch': 'pa', 'params': '' },
}

SYM_ATTR_FONTA = {
    # 'pa' == preserve aspect ratio
    'default': { 'align': 'c', 'valign': 'c', 'stretch': 'pa', 'params': '' },

    # Don't center these arrows vertically
    0xf0dc: { 'align': 'c', 'valign': '', 'stretch': 'pa', 'params': '' },
    0xf0dd: { 'align': 'c', 'valign': '', 'stretch': 'pa', 'params': '' },
    0xf0de: { 'align': 'c', 'valign': '', 'stretch': 'pa', 'params': '' },
}

CUSTOM_ATTR = {
    # 'pa' == preserve aspect ratio
    'default': { 'align': 'c', 'valign': '', 'stretch': '', 'params': '' },
}

# Most glyphs we want to maximize during the scale.  However, there are some
# that need to be small or stay relative in size to each other.
# The following list are those glyphs.  A tuple represents a range.
DEVI_SCALE_LIST  = { 'ScaleGlyph': 0xE60E, 'GlyphsToScale': [ (0xe6bd, 0xe6c3), ] }
FONTA_SCALE_LIST = { 'ScaleGlyph': 0xF17A, 'GlyphsToScale': [ 0xf005, 0xf006, (0xf026, 0xf028), 0xf02b, 0xf02c, (0xf031, 0xf035), (0xf044, 0xf054), (0xf060, 0xf063), 0xf077, 0xf078, 0xf07d, 0xf07e, 0xf089, (0xf0d7, 0xf0da), (0xf0dc, 0xf0de), (0xf100, 0xf107), 0xf141, 0xf142, (0xf153, 0xf15a), (0xf175, 0xf178), 0xf182, 0xf183, (0xf221, 0xf22d), (0xf255, 0xf25b), ] }
OCTI_SCALE_LIST  = { 'ScaleGlyph': 0xF02E, 'GlyphsToScale': [ (0xf03d, 0xf040), 0xf044, (0xf051, 0xf053), 0xf05a, 0xf05b, 0xf071, 0xf078, (0xf09f, 0xf0aa), 0xf0ca, ] }

# Define the character ranges
# Symbol font ranges

PATCH_SET = [
    { 'Enabled': True,                      'Name': "Seti-UI + Custom", 'Filename': "original-source.otf",         'Exact': False,'SymStart': 0xE4FA, 'SymEnd': 0xE52E, 'SrcStart': 0xE5FA,'SrcEnd': 0xE62E,'ScaleGlyph': None,  'Attributes': SYM_ATTR_DEFAULT },
    { 'Enabled': True,                      'Name': "Devicons", 'Filename': "devicons.ttf",                'Exact': False,'SymStart': 0xE600, 'SymEnd': 0xE6C5, 'SrcStart': 0xE700,'SrcEnd': 0xE7C5,'ScaleGlyph': DEVI_SCALE_LIST,'Attributes': SYM_ATTR_DEFAULT },
    { 'Enabled': True,            'Name': "Powerline Symbols", 'Filename': "PowerlineSymbols.otf",        'Exact': True, 'SymStart': 0xE0A0, 'SymEnd': 0xE0A2, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
    { 'Enabled': True,            'Name': "Powerline Symbols", 'Filename': "PowerlineSymbols.otf",        'Exact': True, 'SymStart': 0xE0B0, 'SymEnd': 0xE0B3, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
    { 'Enabled': True,       'Name': "Powerline Extra Symbols", 'Filename': "PowerlineExtraSymbols.otf",   'Exact': True, 'SymStart': 0xE0A3, 'SymEnd': 0xE0A3, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
    { 'Enabled': True,       'Name': "Powerline Extra Symbols", 'Filename': "PowerlineExtraSymbols.otf",   'Exact': True, 'SymStart': 0xE0B4, 'SymEnd': 0xE0C8, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
    { 'Enabled': True,       'Name': "Powerline Extra Symbols", 'Filename': "PowerlineExtraSymbols.otf",   'Exact': True, 'SymStart': 0xE0CA, 'SymEnd': 0xE0CA, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
    { 'Enabled': True,       'Name': "Powerline Extra Symbols", 'Filename': "PowerlineExtraSymbols.otf",   'Exact': True, 'SymStart': 0xE0CC, 'SymEnd': 0xE0D4, 'SrcStart': None,  'SrcEnd': None,  'ScaleGlyph': None,  'Attributes': SYM_ATTR_POWERLINE },
]

# win_ascent and win_descent are used to set the line height for windows fonts.
# hhead_ascent and hhead_descent are used to set the line height for mac fonts.
#
# Make the total line size even.  This seems to make the powerline separators
# center more evenly.
if args.adjustLineHeight:
    if (sourceFont.os2_winascent + sourceFont.os2_windescent) % 2 != 0:
        sourceFont.os2_winascent += 1

    # Make the line size identical for windows and mac
    sourceFont.hhea_ascent = sourceFont.os2_winascent
    sourceFont.hhea_descent = -sourceFont.os2_windescent

# Line gap add extra space on the bottom of the line which doesn't allow
# the powerline glyphs to fill the entire line.
sourceFont.hhea_linegap = 0
sourceFont.os2_typolinegap = 0

# Initial font dimensions
font_dim = {
    'xmin'  :    0,
    'ymin'  :    -sourceFont.os2_windescent,
    'xmax'  :    0,
    'ymax'  :    sourceFont.os2_winascent,
    'width' :    0,
    'height':    0,
}

# Find the biggest char width
# Ignore the y-values, os2_winXXXXX values set above are used for line height
#
# 0x00-0x17f is the Latin Extended-A range
for glyph in range(0x00, 0x17f):
    try:
        (xmin, ymin, xmax, ymax) = sourceFont[glyph].boundingBox()
    except TypeError:
        continue

    if font_dim['width'] < sourceFont[glyph].width:
        font_dim['width'] = sourceFont[glyph].width

    if xmax > font_dim['xmax']: font_dim['xmax'] = xmax

# Calculate font height
font_dim['height'] = abs(font_dim['ymin']) + font_dim['ymax']

# Update the font encoding to ensure that the Unicode glyphs are available.
sourceFont.encoding = 'UnicodeFull'

# Fetch this property before adding outlines
onlybitmaps = sourceFont.onlybitmaps

def get_dim(glyph):
    bbox = glyph.boundingBox()

    return  {
        'xmin'  : bbox[0],
        'ymin'  : bbox[1],
        'xmax'  : bbox[2],
        'ymax'  : bbox[3],

        'width' : bbox[2] + (-bbox[0]),
        'height': bbox[3] + (-bbox[1]),
    }

def set_width(sourceFont, width):
    sourceFont.selection.all()
    for glyph in sourceFont.selection.byGlyphs:
        glyph.width = width

def get_scale_factor(font_dim, sym_dim):
    scale_ratio = 1
    # We want to preserve x/y aspect ratio, so find biggest scale factor that allows symbol to fit
    scale_ratio_x = font_dim['width'] / sym_dim['width']
    # font_dim['height'] represents total line height, keep our symbols sized based upon font's em
    scale_ratio_y = sourceFont.em / sym_dim['height']
    if scale_ratio_x > scale_ratio_y:
        scale_ratio = scale_ratio_y
    else:
        scale_ratio = scale_ratio_x
    return scale_ratio

def use_scale_glyph( unicode_value, glyph_list ):
    for i in glyph_list:
        if isinstance(i, tuple):
            if unicode_value >= i[0] and unicode_value <= i[1]:
                return True
        else:
            if unicode_value == i:
                return True
    return False

## modified from: https://stackoverflow.com/questions/3160699/python-progress-bar
## Accepts a float between 0 and 1. Any int will be converted to a float.
## A value at 1 or bigger represents 100%
def update_progress(progress):
    barLength = 40 # Modify this to change the length of the progress bar
    if isinstance(progress, int):
        progress = float(progress)
    if progress >= 1:
        progress = 1
        status = "Done...\r\n"
    block = int(round(barLength*progress))
    text = "\r╢{0}╟ {1}%".format( "█"*block + "░"*(barLength-block), int(progress*100))
    sys.stdout.write(text)
    sys.stdout.flush()

def copy_glyphs(sourceFont, sourceFontStart, sourceFontEnd, symbolFont, symbolFontStart, symbolFontEnd, exactEncoding, scaleGlyph, setName, attributes):

    progressText = ''
    careful = False
    glyphSetLength = 0

    if args.careful:
        careful = True

    if exactEncoding is False:
        sourceFontList = []
        sourceFontCounter = 0

        for i in range(sourceFontStart, sourceFontEnd + 1):
            sourceFontList.append(format(i, 'X'))

    scale_factor = 0
    if scaleGlyph:
        sym_dim = get_dim(symbolFont[scaleGlyph['ScaleGlyph']])
        scale_factor = get_scale_factor(font_dim, sym_dim)

    # Create glyphs from symbol font

    # If we are going to copy all Glyphs, then assume we want to be careful
    # and only copy those that are not already contained in the source font
    if symbolFontStart == 0:
        symbolFont.selection.all()
        sourceFont.selection.all()
        careful = True
    else:
        symbolFont.selection.select((str("ranges"),str("unicode")),symbolFontStart,symbolFontEnd)
        sourceFont.selection.select((str("ranges"),str("unicode")),sourceFontStart,sourceFontEnd)

    # Get number of selected non-empty glyphs @todo fixme
    for index, sym_glyph in enumerate(symbolFont.selection.byGlyphs):
        glyphSetLength += 1
    # end for

    if args.quiet == False:
        sys.stdout.write("Adding " + str(max(1, glyphSetLength)) + " Glyphs from " + setName + " Set \n")

    for index, sym_glyph in enumerate(symbolFont.selection.byGlyphs):

        index = max(1, index)

        try:
            sym_attr = attributes[sym_glyph.unicode]
        except KeyError:
            sym_attr = attributes['default']

        if exactEncoding:
            # use the exact same hex values for the source font as for the symbol font
            currentSourceFontGlyph = sym_glyph.encoding
            # Save as a hex string without the '0x' prefix
            copiedToSlot = format(sym_glyph.unicode, 'X')
        else:
            # use source font defined hex values based on passed in start and end
            # convince that this string really is a hex:
            currentSourceFontGlyph = int("0x" + sourceFontList[sourceFontCounter], 16)
            copiedToSlot = sourceFontList[sourceFontCounter]
            sourceFontCounter += 1

        if int(copiedToSlot, 16) < 0:
            print("Found invalid glyph slot number. Skipping.")
            continue

        if args.quiet == False:
            if args.progressbars:
                update_progress(round(float(index + 1)/glyphSetLength,2))
            else:
                progressText = "\nUpdating glyph: " + str(sym_glyph) + " " + str(sym_glyph.glyphname) + " putting at: " + copiedToSlot;
                sys.stdout.write(progressText)
                sys.stdout.flush()

        # Prepare symbol glyph dimensions
        sym_dim = get_dim(sym_glyph)

        # check if a glyph already exists in this location
        if careful or 'careful' in sym_attr['params']:
            if copiedToSlot.startswith("uni"):
                copiedToSlot = copiedToSlot[3:]

            codepoint = int("0x" + copiedToSlot, 16)
            if codepoint in sourceFont:
                if args.quiet == False:
                    print("  Found existing Glyph at {}. Skipping...".format(copiedToSlot))
                # We don't want to touch anything so move to next Glyph
                continue

        # Select and copy symbol from its encoding point
        # We need to do this select after the careful check, this way we don't
        # reset our selection before starting the next loop
        symbolFont.selection.select(sym_glyph.encoding)
        symbolFont.copy()

        # Paste it
        sourceFont.selection.select(currentSourceFontGlyph)
        sourceFont.paste()

        sourceFont[currentSourceFontGlyph].glyphname = sym_glyph.glyphname

        scale_ratio_x = 1
        scale_ratio_y = 1

        # Now that we have copy/pasted the glyph, if we are creating a monospace
        # font we need to scale and move the glyphs.  It is possible to have
        # empty glyphs, so we need to skip those.
        if args.single and sym_dim['width'] and sym_dim['height']:

            # If we want to preserve that aspect ratio of the glyphs we need to
            # find the largest possible scaling factor that will allow the glyph
            # to fit in both the x and y directions
            if sym_attr['stretch'] == 'pa':
                if scale_factor and use_scale_glyph(sym_glyph.unicode, scaleGlyph['GlyphsToScale'] ):
                    # We want to preserve the relative size of each glyph to other glyphs
                    # in the same symbol font.
                    scale_ratio_x = scale_factor
                    scale_ratio_y = scale_factor
                else:
                    # In this case, each glyph is sized independently to each other
                    scale_ratio_x = get_scale_factor(font_dim, sym_dim)
                    scale_ratio_y = scale_ratio_x
            else:
                if 'x' in sym_attr['stretch']:
                    # Stretch the glyph horizontally to fit the entire available width
                    scale_ratio_x = font_dim['width'] / sym_dim['width']

        # non-monospace (double width glyphs)
        # elif sym_dim['width'] and sym_dim['height']:
                # any special logic we want to apply for double-width variation
                # would go here

        # end if single width

        if 'y' in sym_attr['stretch']:
            # Stretch the glyph vertically to total line height (good for powerline separators)
            # Currently stretching vertically for both monospace and double-width
            scale_ratio_y = font_dim['height'] / sym_dim['height']

        if scale_ratio_x != 1 or scale_ratio_y != 1:
            if 'overlap' in sym_attr['params']:
                scale_ratio_x *= 1+sym_attr['params']['overlap']
                scale_ratio_y *= 1+sym_attr['params']['overlap']
            sourceFont.transform(psMat.scale(scale_ratio_x, scale_ratio_y))

        # Use the dimensions from the newly pasted and stretched glyph
        sym_dim = get_dim(sourceFont[currentSourceFontGlyph])

        y_align_distance = 0
        if sym_attr['valign'] == 'c':
            # Center the symbol vertically by matching the center of the line height and center of symbol
            sym_ycenter = sym_dim['ymax'] - (sym_dim['height'] / 2)
            font_ycenter = font_dim['ymax'] - (font_dim['height'] / 2)
            y_align_distance = font_ycenter - sym_ycenter

        # Handle glyph l/r/c alignment
        x_align_distance = 0
        if sym_attr['align']:
            # First find the baseline x-alignment (left alignment amount)
            x_align_distance = font_dim['xmin']-sym_dim['xmin']
            if sym_attr['align'] == 'c':
                # Center align
                x_align_distance += (font_dim['width']/2) - (sym_dim['width']/2)
            elif sym_attr['align'] == 'r':
                # Right align
                x_align_distance += font_dim['width'] - sym_dim['width']

        if 'overlap' in sym_attr['params']:
            overlap_width = font_dim['width'] * sym_attr['params']['overlap']
            if sym_attr['align'] == 'l':
                x_align_distance -= overlap_width
            if sym_attr['align'] == 'r':
                x_align_distance += overlap_width

        align_matrix = psMat.translate(x_align_distance, y_align_distance)
        sourceFont.transform(align_matrix)

        # Needed for setting 'advance width' on each glyph so they do not overlap,
        # also ensures the font is considered monospaced on Windows by setting the
        # same width for all character glyphs.
        # This needs to be done for all glyphs, even the ones that are empty and
        # didn't go through the scaling operations.
        sourceFont[currentSourceFontGlyph].width = font_dim['width']

        # Ensure after horizontal adjustments and centering that the glyph
        # does not overlap the bearings (edges)
        if sourceFont[currentSourceFontGlyph].left_side_bearing < 0:
          sourceFont[currentSourceFontGlyph].left_side_bearing = 0.0

        if sourceFont[currentSourceFontGlyph].right_side_bearing < 0:
          sourceFont[currentSourceFontGlyph].right_side_bearing = 0.0

        # reset selection so iteration works properly @todo fix? rookie misunderstanding?
        # This is likely needed because the selection was changed when the glyph was copy/pasted
        if symbolFontStart == 0:
            symbolFont.selection.all()
        else:
            symbolFont.selection.select((str("ranges"),str("unicode")),symbolFontStart,symbolFontEnd)
    # end for

    if args.quiet == False or args.progressbars:
        sys.stdout.write("\n")

    return

if args.extension == "":
    extension = os.path.splitext(sourceFont.path)[1]
else:
    extension = '.'+args.extension

if args.single and extension == '.ttf':
    # Force width to be equal on all glyphs to ensure the font is considered monospaced on Windows.
    # This needs to be done on all characters, as some information seems to be lost from the original font file.
    # This is only a problem with ttf files, otf files seem to be okay.
    set_width(sourceFont, font_dim['width'])

# Prevent opening and closing the fontforge font. Makes things faster when patching
# multiple ranges using the same symbol font.
PreviousSymbolFilename = ""
symfont = None

import platform
print(platform.python_version())
for patch in PATCH_SET:
    if patch['Enabled']:
        print(patch['Name'])
        if PreviousSymbolFilename != patch['Filename']:
            # We have a new symbol font, so close the previous one if it exists
            if symfont:
                symfont.close()
                symfont = None
            symfont = fontforge.open(__dir__+"\src\glyphs\ "+patch['Filename'])
            # Match the symbol font size to the source font size
            symfont.em = sourceFont.em
            PreviousSymbolFilename = patch['Filename']
        # If patch table doesn't include a source start and end, re-use the symbol font values
        SrcStart = patch['SrcStart']
        SrcEnd = patch['SrcEnd']
        if not SrcStart:
            SrcStart = patch['SymStart']
        if not SrcEnd:
            SrcEnd = patch['SymEnd']

        copy_glyphs(sourceFont, SrcStart, SrcEnd, symfont, patch['SymStart'], patch['SymEnd'], patch['Exact'], patch['ScaleGlyph'], patch['Name'], patch['Attributes'])

if symfont:
    symfont.close()

print("\nDone with Path Sets, generating font...")

# the `PfEd-comments` flag is required for Fontforge to save
# '.comment' and '.fontlog'.
sourceFont.generate(args.outputdir + "/" + sourceFont.fullname + extension, flags=(str('opentype'), str('PfEd-comments')))

print("\nGenerated: {}".format(sourceFont.fullname))

if args.postprocess:
    subprocess.call([args.postprocess, args.outputdir + "/" + sourceFont.fullname + extension])
    print("\nPost Processed: {}".format(sourceFont.fullname))

