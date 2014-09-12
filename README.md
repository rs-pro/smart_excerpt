# SmartExcerpt

Allows to create intellegent excerpt fields.

This is an extraction from [RocketCMS](https://github.com/rs-pro/rocket_cms)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smart_excerpt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart_excerpt

## What it does

You have two fields: a mandatory ```text``` and an optional ```excerpt```.
If your ```excerpt``` field is empty, it generates an excerpt of a given length from ```text```.
It will also truncate excerpts if they are more than 20% longer then allowed value

## Usage

Add two fields: ```excerpt``` and ```text```

Add it to your model:

    class Article
      ...
      include SmartExcerpt
      smart_excerpt :excerpt, :text
    end

Then display excerpt:

    Article.first.get_excerpt

All excerpts are passed through strip_tags and html entity decode.

## Options

    Article.first.get_excerpt(25) # same as {words: 25}
    Article.first.get_excerpt(letters: 25)
    Article.first.get_excerpt(sentences: 5)
    Article.first.get_excerpt(trust_multiplier: 3) # allow for much longer manual excerpts
    Article.first.get_excerpt(trust_excerpts: true) # allow any manual excerpts
    Article.first.get_excerpt(keep_headers: true) # do not remove HTML headers from excerpt
    Article.first.get_excerpt(keep_newlines: true) # do not remove newlines from excerpt
    Article.first.get_excerpt(keep_html: true) # do not remove HTML tags from excerpt (might be unsafe/dangerous!)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/smart_excerpt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
