try:
    from setuptools import setup, Extension
except ImportError:
    from distutils.core import setup, Extension

from Cython.Distutils import build_ext
import pkg_resources
import platform
import re
import subprocess
import commands
import numpy

def pkgconfig(*packages, **kw):
    flag_map = {'-I': 'include_dirs', '-L': 'library_dirs', '-l': 'libraries'}
    for token in commands.getoutput("pkg-config --libs --cflags %s" % ' '.join(packages)).split():
        kw.setdefault(flag_map.get(token[:2]), []).append(token[2:])
    return kw

def is_clang(bin):
    proc = subprocess.Popen([bin, '-v'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = proc.communicate()
    output = '\n'.join([stdout, stderr])
    return not re.search(r'clang', output) is None

class my_build_ext(build_ext):
    def build_extensions(self):
        binary = self.compiler.compiler[0]
        if is_clang(binary):
            for e in self.extensions:
                if platform.system() == 'Darwin':
                    e.extra_compile_args.append('-mmacosx-version-min=10.7')
        build_ext.build_extensions(self)


compile_args = []

pkgconfig_flags = pkgconfig('hmsbeagle-1')
pkgconfig_flags['include_dirs'].extend([numpy.get_include()])

ext = Extension("pybeagle",
                sources = ['pybeagle.pyx',
                           'src/beagle_wrapper.c'],
                language="c",
                extra_compile_args=compile_args,
                **pkgconfig_flags
               )

setup(cmdclass={'build_ext':build_ext},
      name="beagle",
      author='Kevin Gori',
      author_email='kgori@ebi.ac.uk',
      description='Wrapper of hmsbeagle',
      url='',
      version="0.0.1",
      ext_modules = [ext],

      install_requires = ['cython',
                          'numpy'],

     )
