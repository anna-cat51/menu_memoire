class AddFulltextIndexToSearchContents < ActiveRecord::Migration[7.0]
  def self.up
    execute 'create fulltext index search_contents_fulltext_index on search_contents (repertoire_name,ingredient_name);'
  end

  def self.down
    execute 'drop index search_contents_fulltext_index on search_contents;'
  end
end
