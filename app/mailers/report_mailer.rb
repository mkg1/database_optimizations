class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.send_report.subject
  #
  def send_report(address, file)
    @greeting = "Hello. Your requested report is attached."

    attachments['report.csv'] = File.read(file)
    mail to: address, subject: "The report you requested"

  end
end
