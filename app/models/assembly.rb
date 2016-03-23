class Assembly < ActiveRecord::Base
  has_many :sequences
  has_many :genes, through: :sequences
  has_many :hits, through: :genes

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     a = Assembly.create!(name: row["Assembly Name"], run_on: row["Assembly Date"])
  #   end
  # end
end
