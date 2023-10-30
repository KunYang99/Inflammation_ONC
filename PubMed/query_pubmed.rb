require 'bio'
require 'csv'

out = CSV.open('re/pubmed_immune_all.csv', 'w')
out << ["gene", "count"]

cnt = 0
CSV.foreach('../DEG/re/deseq2_coding_FEP_HC.csv', headers:true) do |row|
  cnt += 1
  puts "working on #{cnt}"
  re = Bio::PubMed.esearch("#{row[0]} AND (immune OR inflammation OR inflammatory)", {'retmax' => 10000})
  out << [row[0], re.size]
  sleep 5 
end
out.close
