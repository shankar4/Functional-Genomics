#Application 2: Converting accession numbers to data
#Goal: Starting with a list of protein accession numbers, return the sequences in FASTA format.
#Solution: Create a string consisting of items separated by 'OR', where each item is an accession number #followed by '[accn]'.
#Example: accn1[accn]+OR+accn2[accn]+OR+accn3[accn]+OR+…
#Submit this string as a &term in ESearch, then use EFetch to retrieve the FASTA data.
#Input: $acc_list – comma-delimited list of accessions
#Output: FASTA data

use LWP::Simple;
$acc_list = 'NM_009417,NM_000547,NM_001003009,NM_019353';
@acc_array = split(/,/, $acc_list);

#append [accn] field to each accession
for ($i=0; $i < @acc_array; $i++) {
   $acc_array[$i] .= "[accn]";
}

#join the accessions with OR
$query = join('+OR+',@acc_array);

#assemble the esearch URL
$base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "esearch.fcgi?db=nuccore&term=$query&usehistory=y";

#post the esearch URL
$output = get($url);

#parse WebEnv and QueryKey
$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);

#assemble the efetch URL
$url = $base . "efetch.fcgi?db=nuccore&query_key=$key&WebEnv=$web";
$url .= "&rettype=fasta&retmode=text";

#post the efetch URL
$fasta = get($url);
print "$fasta";
