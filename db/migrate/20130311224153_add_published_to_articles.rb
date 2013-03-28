class AddPublishedToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
        t.boolean :published, :default => false
      end
    end

    def self.down
      remove_column :articles, :published
    end
  end