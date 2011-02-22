
class CreateTable < ActiveRecord::Migration
  
  def self.up

    create_table "minitest_test_methods", :force => true do |t|
      t.string "project", :null => false
      t.string "machine", :null => false
      t.string "test_id", :null => false

      t.string "klass", :null => false
      t.string "method", :null => false
      t.boolean "exception", :null => false
      t.time "execution_time", :null => false
    end
    
  end
  
end