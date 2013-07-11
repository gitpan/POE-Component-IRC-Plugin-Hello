use 5.014000;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'POE::Component::IRC::Plugin::Hello',
    VERSION_FROM     => 'lib/POE/Component/IRC/Plugin/Hello.pm',
	ABSTRACT_FROM    => 'lib/POE/Component/IRC/Plugin/Hello.pm',
	AUTHOR           => 'Marius Gavrilescu <marius@ieval.ro>',
	MIN_PERL_VERSION => 5.014000,
	LICENSE          => 'perl',
	SIGN             => 1,
    PREREQ_PM        => {
	  'List::Util' => 0,
	  'IRC::Utils' => 0,
	  'POE::Component::IRC::Plugin' => 0,
	},
	BUILD_REQUIRES   => {
	  'Test::MockObject' => 1.09,
	},
);
