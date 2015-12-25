module Risp

  class Parser

    def tokenize program
      return program.gsub('(', ' ( ').gsub(')', ' ) ').split
    end

    def parse program
      return read_from_tokens(tokenize(program))
    end

    def read_from_tokens tokens

      if tokens.size == 0
        raise SyntaxError, 'unexpected EOF while reading'
      end

      token = tokens.slice!(0)

      if '(' == token
        l = []
        while tokens[0] != ')' do
          l.push(read_from_tokens(tokens))
        end
        tokens.delete_at(0)
        return l
      elsif ')' == token
        raise SyntaxError, %q{unexpected ')'}
      else
        return atom(token)
      end
    end

    # Interprets a token as either a Float, Integer, or Symbol
    # and returns it as a native Ruby type.
    def atom token
      begin
        if token.is_a?(String) && token.match(/[-+]?[0-9]*\.[0-9]+/) != nil
          return Float(token)
        else
          return Integer(token)
        end
      rescue
        return token.to_sym
      end
    end

  end

end
