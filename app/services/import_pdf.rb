require 'pdf-reader'

class ImportPDF
    attr_reader :reader, :dictionary
    UNIMPORT_FILE_NAME = Rails.root + 'app/services/other_document.txt'
  
    def initialize
      @reader = PDF::Reader.new('app/assets/dictionary_pdf/TuDienMoussay.pdf')

      ImportData.destroy_all if ImportData.all
      File.delete(UNIMPORT_FILE_NAME) if File.exist?(UNIMPORT_FILE_NAME)
    end
  
    def import
      puts 'starting...'
      # debugger
      (0..paragraphs.size - 1).each do |i|
        sentence = paragraphs[i]
        cham_word = count_cham_word(sentence)
        meaning_word = count_meaning_word(sentence)
  
        if sentence.include?(' [Cam M]:') && (meaning_word == 0)
          document = build_without_meaning_include_source_name(sentence, cham_word, meaning_word)
        elsif sentence.include?(' [Cam M]:') && (meaning_word >= 1 && meaning_word <= 3)
          document = build_pronunciation_only(sentence, cham_word, meaning_word)
        elsif sentence.include?(' [Cam M] ') && sentence.include?('≠')
          document = build_fulfill_sentence(sentence, cham_word)
        elsif sentence.include?(' [Cam M]: ') && sentence.include?('≠')
          document = build_fulfill_sentence_include_colon(sentence, cham_word)
        elsif sentence.include?(' [Cam M] ')
          document = build_french_meaning_only(sentence, cham_word)
        elsif sentence.include?(' [Cam M]: ')
          document = build_french_meaning_only_include_colon(sentence, cham_word)
        elsif sentence.include?(' [Cam M]:')
          document = build_fulfill_sentence_include_special_colon(sentence, cham_word)
        elsif sentence.include?('[Cam M')
          document = build_error_page1(sentence)
        elsif sentence.include?('G. Moussay') || sentence.include?('Tu Dien Cham-Viet-Phap') || sentence.include?(('Po Dharma'))
          # File.open(UNIMPORT_FILE_NAME, 'a') { |file| file.write(sentence + "\n") }
          next
        elsif !sentence.match?(/\d/)
          document = build_without_meaning(sentence, cham_word)
        end
  
        # debugger unless document
        if document
          import_data = ImportData.new
          # debugger
          import_data.rumi = document[:rumi]
          import_data.akharThrah = document[:akharThrah]
          import_data.source = document[:source]
          import_data.vietnamese = document[:vietnamese]
          import_data.french = document[:french]
          import_data.pronunciation = document[:pronunciation]
          import_data.fullDescription = document[:fullDescription]
          import_data.save
        else
          File.open(UNIMPORT_FILE_NAME, 'a') { |file| file.write(sentence + "\n") } 
        end
      end
      puts 'There are ' + ImportData.count.to_s + ' data in databases.'
      puts 'done'
    end
  
    private
  
    def paragraphs
      return @paragraphs if @paragraphs
  
      paragraph = ''
      @paragraphs = []
  
      page = reader.page(1)
      # reader.pages.each do |page|
      lines = page.text.scan(/^.+/)
      # debugger
      # puts 'lines', lines
      lines.each do |line|
  
        if line.length > 55
          paragraph += " #{line}"
          # puts 'paragrap 1', paragraph
        elsif
          paragraph += " #{line}"
          # puts 'paragrap 2', paragraph
          @paragraphs << paragraph
          paragraph = ''
        end
        # puts 'paragraps', paragraphs
      end
  
      # end
      # puts 'paragraps', paragraphs
      @paragraphs
      # debugger
    end
  
    def count_cham_word(sentence)
      if sentence.include?('[Cam M]')
        groups = sentence.split('[Cam M]', 2)
        chams = groups[0].split
        count_word = chams.count
      elsif !sentence.match?(/\d/)
        chams = sentence.split
        count_word = chams.count
      end
      count_word
    end
  
    def count_meaning_word(sentence)
      if sentence.include?('[Cam M]')
        groups = sentence.split('[Cam M]', 2)
        meaning = groups[1]
        count_word = meaning.count '^: .' # count except ':', '.' and ' '
      end
      count_word
    end
  
  
    def build_fulfill_sentence(sentence, cham_word)
      return unless sentence.include?(' [Cam M] ') && sentence.include?('≠')
  
      groups = sentence.split(' [Cam M] ', 2)
      chams = groups[0].split(' ')
      meanings = groups[1].split('≠', 2)
      french = meanings[1].split('.', 2)
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: meanings[0],
        french: french[0],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_fulfill_sentence_include_colon(sentence, cham_word)
      return unless sentence.include?(' [Cam M]: ') && sentence.include?('≠')
  
      groups = sentence.split(' [Cam M]: ', 2)
      chams = groups[0].split(' ')
      meanings = groups[1].split('≠', 2)
      french = meanings[1].split('.', 2)
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: meanings[0],
        french: french[0],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_french_meaning_only(sentence, cham_word)
      return unless sentence.include?(' [Cam M] ')
  
      groups = sentence.split(' [Cam M] ', 2)
      chams = groups[0].split(' ')
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: nil,
        french: groups[1],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_french_meaning_only_include_colon(sentence, cham_word)
      return unless sentence.include?(' [Cam M]: ')
  
      groups = sentence.split(' [Cam M]: ', 2)
      chams = groups[0].split(' ')
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: nil,
        french: groups[1],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_fulfill_sentence_include_special_colon(sentence, cham_word)
      return unless sentence.include?(' [Cam M]:') && sentence.include?('≠')
  
      groups = sentence.split(' [Cam M]:', 2)
      chams = groups[0].split(' ')
      meanings = groups[1].split('≠', 2)
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: meanings[0],
        french: meanings[1],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_error_page1(sentence) # One word is error in page 1
      return unless sentence.include?('[Cam M')
  
      groups = sentence.split('[Cam M', 2)
      chams = groups[0].split(' ', 2)
  
      {
        rumi: chams[0],
        akharThrah: chams[1],
        source: 'Cam M',
        vietnamese: nil,
        french: groups[1],
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
    
    def build_without_meaning_include_source_name(sentence, cham_word, meaning_word)
      return unless sentence.include?(' [Cam M]:') && (meaning_word == 0)
  
      groups = sentence.split(' [Cam M]:', 2)
      chams = groups[0].split(' ')
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: nil,
        french: nil,
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_pronunciation_only(sentence, cham_word, meaning_word)
      return unless sentence.include?(' [Cam M]:') && (meaning_word >= 1 && meaning_word <= 3)
  
      groups = sentence.split(' [Cam M]:', 2)
      chams = groups[0].split(' ')
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: nil,
        french: nil,
        pronunciation: groups[1].delete(':. '),
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
    def build_without_meaning(sentence, cham_word)
      
      return unless !sentence.match?(/\d/)
  
      chams = sentence.split(' ')
  
      {
        rumi: chams[0, cham_word / 2].join(' '),
        akharThrah: chams[cham_word / 2, cham_word / 2].join(' '),
        source: 'Cam M',
        vietnamese: nil,
        french: nil,
        pronunciation: nil,
        # fullDescription: sentence
        fullDescription: nil
      }
    end
  
  end
  