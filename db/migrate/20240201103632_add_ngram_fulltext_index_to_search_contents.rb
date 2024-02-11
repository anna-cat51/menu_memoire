class AddNgramFulltextIndexToSearchContents < ActiveRecord::Migration[7.0]
  def self.up
    execute 'create fulltext index search_contents_ngram_fulltext_index on search_contents (repertoire_name_ngram,ingredient_name_ngram);'
  end

  def self.down
    execute 'drop index search_contents_ngram_fulltext_index on search_contents;'
  end
end
