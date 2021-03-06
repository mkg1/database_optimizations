class ReportsController < ApplicationController
  helper_method :memory_in_mb

  def all_data
    # @start_time = Time.now
    # @assembly = Assembly.find_by_name(params[:name])
    # @hits = @assembly.hits
    # # @hits.sort! {|a, b| b.percent_similarity <=> a.percent_similarity}
    # @hits.order(percent_similarity: :desc)
    # # @hits.where(subject_id: Gene.where(sequence_id: Sequence.where(assembly_id: @assembly.id))).order(percent_similarity: :desc)
    # @memory_used = memory_in_mb
  end

  def send_email
    SendReportJob.perform_later(params[:address], params[:query], params[:limit])
  end

  def search
    @q = "%#{params[:search]}%"
    # @assembly = Assembly.all
    @assemblies = Assembly.where("name LIKE ?", @q)
    @genes = Gene.where("dna LIKE ?", @q)
    @hits = Hit.where("match_gene_name LIKE ?", @q)
  end

  def choose_file
  end

  def import
    ImportCsvJob.perform_later(params[:file].path)
  end

  private def memory_in_mb
    `ps -o rss -p #{$$}`.strip.split.last.to_i / 1024
  end
end
