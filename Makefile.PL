use inc::Module::Install;

name     'Framework-Orangemash';
all_from 'lib/Framework/Orangemash.pm';
author   'Robert Krimen <rkrimen@cpan.org>';
license  'perl';

build_requires 'Test::More';

tests_recursive;

auto_install;

WriteAll;

