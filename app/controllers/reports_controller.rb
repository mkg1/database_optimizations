class ReportsController < ApplicationController
  helper_method :memory_in_mb

  def all_data
    @start_time = Time.now

    # @sequences = []
    # @genes = []
    # @hits = []
    @assembly = Assembly.find_by_name(params[:name])
    # @assembly.sequences.each do |s|
    #   @sequences << s
    #   s.genes.each do |g|
    #     @genes << g
    #     g.hits.each do |h|
    #       @hits << h
    #     end
    #   end
    # end
    @hits = @assembly.hits
    # @hits.sort! {|a, b| b.percent_similarity <=> a.percent_similarity}
    @hits.order(percent_similarity: :desc)

    # @hits.where(subject_id: Gene.where(sequence_id: Sequence.where(assembly_id: @assembly.id))).order(percent_similarity: :desc)
    @memory_used = memory_in_mb
  end

#Example sql from class:
  #SELECT
  #FROM assemblies AS a
  # INNER JOIN sequences AS s ON a.id = s.assembly_id
  # INNER JOIN genes AS g ON s.id = g.sequence_id
  # INNER JOIN hits AS h ON g.id = h.subject_id AND h.subject_type = "Gene" -->bc of polymorphic association, you have to specify that it's a hit for a gene
  #WHERE a.name LIKE "%a%"
  # OR g.dna LIKE "%a%"
  # OR h.match_gene_name LIKE "%a%"

  def search
    @q = "%#{params[:search]}%"
    # @assembly = Assembly.all
    @assemblies = Assembly.where("name LIKE ?", @q)
    @genes = Gene.where("dna LIKE ?", @q)
    @hits = Hit.where("match_gene_name LIKE ?", @q)
    #
    # @hits = Hit.joins("AS h JOIN genes ON g.id = h.subject_id AND h.subject_type = 'Gene'")
    #     .joins("JOIN sequences AS s ON s.id = g.sequence_id")
    #     .joins("JOIN assemblies AS a ON a.id = s.assembly_id")
    #     .where("a.name LIKE '%a%' OR g.dna LIKE '%a%' OR h.match_gene_name LIKE '%a%'",
    #       params[:search], params[:search], params[:search])
    #     .order("h.percent_similarity DESC")
  end

  def choose_file
  end

  def import
    # @assembly = Assembly.import(params[:file])
    # CSV.foreach(params[:file].path, headers: true) do |row|
    #   a = Assembly.create!(name: row["Assembly Name"], run_on: row["Assembly Date"])
    #   g = Gene.create!(dna: row["Gene Sequence"], starting_position: row["Gene Starting Position"], direction: row["Gene Direction"], sequence_id: a.id)
    #   s = Sequence.create!(dna: quality: assembly_id: )
    @import = Array.new
    CSV.foreach(params[:file].path, headers: true) do |row|
      @import << row[0]
    end
  end

  private def memory_in_mb
    `ps -o rss -p #{$$}`.strip.split.last.to_i / 1024
  end
end
