#!/usr/bin/perl
use utf8;
binmode STDOUT, ":utf8";

my $temp = "^пяун\$";

my @dict = ('^каун$','^перун$','^сапун$','^джоджен$','^перон$','^асма$','^сал$','^паун$');

 
#^абвгдежзийклмнопрстуфхцчшщъьюя$
#^000000000000000010000000000000
#а000000000000000000010000000000
#б000000000000000000000000000000
#в000000000000000000000000000000
#г000000000000000000000000000000
#д000000000000000000000000000000
#е000000000000000000000000000000
#ж000000000000000000000000000000
#з000000000000000000000000000000
#и000000000000000000000000000000
#й000000000000000000000000000000
#к000000000000000000000000000000
#л000000000000000000000000000000
#м000000000000000000000000000000
#н000000000000000000000000000000
#о000000000000000000000000000000
#п100000000000000000000000000000
#р000000000000000000000000000000
#с000000000000000000000000000000
#т000000000000000000000000000000
#у000000000000100000000000000000
#ф000000000000000000000000000000
#х000000000000000000000000000000
#ц000000000000000000000000000000
#ч000000000000000000000000000000
#ш000000000000000000000000000000
#щ000000000000000000000000000000
#ъ000000000000000000000000000000
#ь000000000000000000000000000000
#ю000000000000000000000000000000
#я000000000000000000000000000000

my @alphabet = ('^','а','б','в','г','д','е','ж','з','и','й','к','л','м','н','о','п','р','с','т','у','ф','х','ч','ш','щ','ъ','ь','ю','я','$');

my %lookup = {};


sub print_alpha()
{
	foreach $item (@alphabet)
{
	printf("%s",$item);
}
printf("\n");
}

sub init()
{
my $k = 0;

foreach $item (@alphabet)
{
	printf("%s",$item);
		
	$lookup{$item} = $k++;
}
}

init();


sub get_mat($)
{
	
my ($temp) = (@_);

my $t = sprintf("%d",0);

@items = split(//,$temp);

my $prev = -1;

my @mat = ();

for($i=0; $i <= $#items; $i++)
{

$mat[$prev] |= (2<<(29-$lookup{$items[$i]})) if $prev ne -1;

#printf("%s\n",$items[$i]);
#printf("%s\n",$lookup{$items[$i]});

$t |= (2<<(30-$lookup{$items[$i]}));

$prev = $lookup{$items[$i]};

}

printf("%031b\n",$t);


printf("\n\n");

foreach $item (@alphabet)  
{                          
	printf("%s",$item);
}
printf("\n");
for($i = 0; $i <= 32; $i++)
{
	printf("%031b\n",$mat[$i]);
}

my $result = pack("L[31]",@mat);

($result);

}

printf("\n\n");

my %lookup = {};

foreach $word (@dict)
{
	@tmat = ();
	my $mat = get_mat($word);
	
	$lookup{$mat} = $word; #todo duplicates
	
	@tmat = unpack("L[31]",$mat);
	printf("result:%s\n\n",$word);
	print_alpha();

	for($i = 0; $i <= $#tmat; $i++)
	{
		printf("%031b\n",$tmat[$i]);
	}	
	printf("\n");
}



my $poc = "^пяун\$";


my $qmat = get_mat($poc);
my @qamat = unpack("L[31]",$qmat);

my %results = ();

foreach $item (keys %lookup)
{
	my @samat = unpack("L[31]",$item);
	
	my $diff = 0;
	
	for($i = 0; $i < 31; $i++)
	{
		#printf("%032b %032b %032b\n",$qamat[$i],$samat[$i],$qamat[$i]^$samat[$i]);
		my $tempxor = $qamat[$i] ^ $samat[$i];
		my $resxor  = unpack("%32B*",$tempxor);
		
		#printf("%d",$resxor);
		$diff += $resxor;
		
	}
	#printf("%d,%s\n",$diff,$lookup{$item});	
	$results{$diff} = $lookup{$item};
}

printf("\n");
printf("searching for:%s -> ",$poc);
my $l = 0;
foreach $item (sort keys %results)
{
	printf("%s\n",$results{$item});
	last if !$l++
}










