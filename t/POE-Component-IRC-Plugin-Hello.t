use v5.14;
use strict;
use warnings;

use Test::More tests => 15;
use Test::MockObject;

BEGIN { use_ok('POE::Component::IRC::Plugin::Hello') };

# Variable setup
my $hello_sent;

my $mockirc = Test::MockObject->new;
$mockirc->mock(yield => sub { $hello_sent = 1 })->set_always(nick_name => 'hellobot');

my $self = POE::Component::IRC::Plugin::Hello->new;
my $channels = [ '#chan' ];

# Sub setup
sub runtest{
  my ($message, $expect, $comment) = @_;
  $hello_sent=0;
  $self->S_public($mockirc, \'mgv!marius@ieval.ro', \$channels, \$message);
  ok($hello_sent == $expect, $comment)
}

#Tests
runtest 'privet', 1, 'simple privet';
runtest 'PrIvEt', 1, 'privet in mixed case';
runtest '  privet  ', 1, 'privet with spaces';
runtest 'hellobot: privet', 1, 'addressed privet';
runtest 'hellobot:    privet   ', 1, 'addressed privet with spaces';
runtest 'ahoy', 1, 'ahoy';
runtest 'namaste', 1, 'namaste';
runtest 'neaţa', 1, 'neaţa (UTF-8 test)';
runtest 'こんにちは', 1, 'こんにちは (another UTF-8 test)';

runtest 'salu', 0, 'salu (misspelling)';
runtest 'hii', 0, 'hii (misspelling)';
runtest 'neaţa mgv', 0, 'neaţa mgv (valid greeting with garbage after it)';

$self = POE::Component::IRC::Plugin::Hello->new(greetings => ['sayonara']);

runtest 'privet', 0, 'custom greetings - privet';
runtest '  sayonara   ', 1, 'custom greetings - sayonara';
