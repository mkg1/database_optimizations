class Gene < ActiveRecord::Base
  belongs_to :sequence
  belongs_to :assembly
  has_many :hits, as: :subject

  validates :sequence_id, presence: true

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     g = Gene.create!(dna: row["Gene Sequence"], starting_position: row["Gene Starting Position"], direction: row["Gene Direction"], sequence_id: row[""])
  #   end
  # end
end
