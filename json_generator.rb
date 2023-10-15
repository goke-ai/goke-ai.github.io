module Jekyll
    require 'json'
  
    class JSONGenerator < Generator
      safe true
      priority :low
  
      def generate(site)
        # Converter for .md > .html
        converter = site.getConverterImpl(Jekyll::Converters::Markdown)
  
        # Iterate over all posts
        site.posts.each do |post|
          # Encode the HTML to JSON
          hash = { "content" => converter.convert(post.content) }
          title = post.title.downcase.tr(' ', '-').delete("’!")
  
          # Write the JSON file
          File.open("#{site.dest}/#{title}.json", 'w') do |file|
            file.write(JSON.pretty_generate(hash))
          end
        end
      end
    end
  end
  