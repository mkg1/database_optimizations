class SendReportJob < ActiveJob::Base
  queue_as :emails

  def perform(*args)
    @assembly = Assembly.find_by_name("a1")
    @hits = @assembly.hits
    file_path = Rails.root.join("tmp", "report#{rand(10000)}.csv")
    CSV.open(file_path, "w") do |csv|
      csv << ["Matching Gene Name", "Matching DNA", "Percent Similarity"]
        @hits.each do |hit|
          csv << [hit.match_gene_name, hit.match_gene_dna.first(100), hit.percent_similarity]
        end
      end
    ReportMailer.send_report(args[0], file_path).deliver_now
  end
end


#   def perform(*args)
#     branch = Branch.find(args[0])
#     file_path = Rails.root.join("tmp", "report#{rand(10000)}.csv")
#     CSV.open(file_path, "w") do |csv|
#       csv << ["Branch Name", "Account Owner", "Payee", "Amount", "When"]
#       branch.accounts.each do |a|
#         a.expenses.each do |e|
#           csv << [branch.name, a.owner, e.payee, e.amount, e.paid_at]
#         end
#       end
#     end
#     ReportMailer.send_report(file_path).deliver_now
#   end
# end
