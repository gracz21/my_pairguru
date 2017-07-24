class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    brackets = { '{' => '}', '(' => ')', '[' => ']' }
    brackets_stack = []
    valid = true

    record.title.each_char.with_index do |c, i|
      brackets_stack << [brackets[c], i] if brackets.key?(c)

      if brackets.value?(c)
        last_bracket = brackets_stack.pop
        if last_bracket.nil? || last_bracket[0] != c || last_bracket[1] + 1 == i
          valid = false
          break
        end
      end
    end

    record.errors.add(:title, 'has unclosed bracket') unless brackets_stack.empty? && valid
  end
end