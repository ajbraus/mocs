class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name

      t.timestamps
    end
    Goal.create(name: "Patient Outcomes")
    Goal.create(name: "Cost Effectiveness")
    Goal.create(name: "Patient Satisfaction")
    Goal.create(name: "Process Improvement")
  end
end
