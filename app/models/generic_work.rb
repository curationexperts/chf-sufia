# Generated via
#  `rails generate curation_concerns:work GenericWork`
class GenericWork < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include Sufia::WorkBehavior
  include GenericMetadata

  self.human_readable_type = 'Work'
  self.indexer = ::GenericWorkIndexer

  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

end
