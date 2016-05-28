module Crimson
  #
  # Crimson S-Expression Parser
  # ---------------------------
  #
  # author: Jason Wijegooneratne
  # date:   19-May-2016
  #
  #
  class Parser
    def parse(str)
      state = :token_start
      tokens = []
      word = ""

      str.each_char do |char|
        case state
        when :token_start
          case char
          when '('
            tokens << :left_bracket
          when ')'
            tokens << :right_bracket
          when /\s/
          # ignore
          when '"'
            state = :read_quoted_string
            word = ""
          else
            state = :read_string_or_number
            word = char
          end

        when :read_quoted_string
          case char
          when '"'
            tokens << word
            state = :token_start
          else
            word << char
          end

        when :read_string_or_number
          case char
          when /\s/
            tokens << symbol_or_number(word)
            state = :token_start
          when ')'
            tokens << symbol_or_number(word)
            tokens << :right_bracket
            state = :token_start
          else
            word << char
          end
        end
      end
      sexpr_tokens_to_array(tokens)
    end

    def symbol_or_number(word)
      Integer(word)
    rescue ArgumentError
      begin
        Float(word)
      rescue ArgumentError
        word.to_sym
      end
    end

    def sexpr_tokens_to_array(tokens, idx = 0)
      result = []
      while idx < tokens.length
        case tokens[idx]
        when :left_bracket
          tmp, idx = sexpr_tokens_to_array(tokens, idx + 1)
          result << tmp
        when :right_bracket
          return [result, idx]
        else
          result << tokens[idx]
        end
        idx += 1
      end
      result
    end
  end
end
