class BatchEditForm < Sufia::Forms::BatchEditForm
  require_dependency Rails.root.join('lib','chf','utils','parse_fields')

  CHF::Utils::ParseFields.external_ids_hash.keys.each do |k|
    attr_accessor "#{k}_external_id".to_s
  end

  self.terms = [
    # Single-value fields don't work
    #:division,
    #:physical_container,
    #:rights_holder,
    #:file_creator,
    :identifier,
    :admin_note,
    # Nested attributes don't work
    #:date_of_work,
    #:inscription,
    #:additional_credit,
    :resource_type,
    :subject, :language,
    :related_url,
    :artist,
    :author,
    :addressee,
    :creator_of_work,
    :contributor,
    :engraver,
    :interviewee,
    :interviewer,
    :manufacturer,
    :photographer,
    :printer_of_plates,
    :publisher,
    :place_of_interview,
    :place_of_manufacture,
    :place_of_publication,
    :place_of_creation,
    :genre_string,
    :medium,
    :extent,
    :description,
    :series_arrangement,
    :rights
  ]

  self.required_fields = []

  private

    # It's a multi-value field
    def self.encode_external_id(params, clean_params)
    #unless params['identifier'].nil?
      result = []
      CHF::Utils::ParseFields.external_ids_hash.keys.each do |k|
        param = "#{k}_external_id"
        if params[param].present?
          params[param].each do |id_value|
            result << "#{k}-#{id_value}" unless id_value.empty?
          end
        end
      end
      unless result.empty?
        clean_params['identifier'] = result
      end
      clean_params
    end


end
