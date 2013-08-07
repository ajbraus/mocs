class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name

      t.timestamps
    end
    Goal.create(name: "Outcomes")
    Goal.create(name: "Costs")
    Goal.create(name: "Satisfaction")
    Goal.create(name: "Process")
  end
end
