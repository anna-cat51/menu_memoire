class Analyze
  DEFAULT_FORMAT = {node_format: '%m\s%f[7]\s', unk_format: '%m\s', eos_format: ''}

  def self.parse(string, format = DEFAULT_FORMAT)
    Natto::MeCab.new(format).parse(string).strip
  end

  def self.ngram(string, separator= ' ')
    NGram.new({size: 2, word_separator: "", padchar: ""}).parse(string).join(separator)
  end
end