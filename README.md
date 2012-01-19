# Wikail: Your favorite email-based Wiki

## Supported commands

    :list
    :show title
    :create title
    :update title
    :delete title

* Commands must appear in the first line of the message
* All other content is treated as the body of the document
* You can use the keyword :end to mark the end of the body

## Example scenario

#### Create a new document entitled "Contacts"

    :create Contacts

    Bob 3344-5566
    Alice 9900-1122

#### List the available documents

    :list

You'll receive a message like:

    Documents:

    Contacts

#### Read a document

    :show Contacts

Response:

    Bob 3344-5566
    Alice 9900-1122

#### Update a document

    :update Contacts

    Bob 3344-5566
    Alice 9900-1122
    David 1122-3344

* Internally :update is an alias for :create
* Be careful! The default engine (FileEngine) works on mode truncate.

#### Delete a document

    :delete Contacts

## Consuming emails

Create a new `config/environment.rb` based on the example given and run
`bin/wikail`