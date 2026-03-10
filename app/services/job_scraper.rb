require 'httparty'

class JobScraper
  def call
    holder = HTTParty.get("https://remoteok.com/api/", headers: { "Accept-Charset" => "utf-8" })
    jobs = JSON.parse(holder.body.force_encoding("UTF-8"))

    jobs[1..].each do |job|
      description = clean_text(job['description'].to_s)

      Job.find_or_create_by(source_url: job['url']) do |j|
        j.title       = job['title'].presence || job['position'].presence || 'Untitled'
        j.company     = job['company']
        j.location    = job['location']
        j.description = description
        j.visa_friendly = visa_friendly?(description)
        j.scraped_at  = Time.now
      end
    end
  end

  private

  def clean_text(text)
    text = text.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
    text = text.gsub(/<\/?[^>]*>/, " ")
    text = text.gsub(/Please mention the word.*$/m, "")
    text.squish
  end

  def visa_friendly?(description)
    keywords = ["sponsor", "visa", "work rights", "international students", "relocation"]
    keywords.any? { |kw| description.downcase.include?(kw) }
  end
end