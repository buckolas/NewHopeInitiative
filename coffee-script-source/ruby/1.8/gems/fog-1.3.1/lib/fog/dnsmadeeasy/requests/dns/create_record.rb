module Fog
  module DNS
    class DNSMadeEasy
      class Real

        # Creates a record with the representation specified in the request content. Returns errors if record is not valid.
        # Note that a record ID will be generated by the system with this request and any ID that is sent will be ignored. Records are not modifiable for domains that are locked to a template.
        #
        # ==== Parameters
        # * domain<~String> Domain name.
        # * name<~String> Record name.
        # * type<~String> Record type. Values: A, AAAA, CNAME, HTTPRED, MX, NS, PTR, SRV, TXT
        # * data<~String> Record data
        # * options<~Hash> - optional
        #   * ttl<~Integer> Time to live. The amount of time a record will be cached before being refreshed. Default: 1800 (30 mins)
        #   * gtdLocation<~String> Global Traffic Director location. Values: DEFAULT, US_EAST, US_WEST, EUROPE
        #   * password<~String> For A records. Password used to authenticate for dynamic DNS.
        #   * description<~String> For HTTPRED records. A description of the HTTPRED record.
        #   * keywords<~String> For HTTPRED records. Keywords associated with the HTTPRED record.
        #   * title<~String> For HTTPRED records. The title of the HTTPRED record.
        #   * redirectType<~String> For HTTPRED records. Type of redirection performed. Values: Hidden Frame Masked, Standard - 302, Standard - 301
        #   * hardLink<~Boolean> For HTTPRED records.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~Integer> Unique record identifier
        #     * name<~String>
        #     * type<~String>
        #     * data<~String>
        #     * ttl<~Integer>
        #     * gtdLocation<~String>
        #     * password<~String>
        #     * description<~String>
        #     * keywords<~String>
        #     * title<~String>
        #     * redirectType<~String>
        #     * hardLink<~Boolean>
        #   * 'status'<~Integer> - 201 - record successfully created, 400 - record not valid, see errors in response content, 404 - domain not found
        def create_record(domain, name, type, data, options = {})

          body = {
            "name" => name,
            "type" => type,
            "data" => data,
            "ttl"  => 1800
          }

          body.merge!(options)

          request(
            :expects  => 201,
            :method   => "POST",
            :path     => "/V1.2/domains/#{domain}/records",
            :body     => MultiJson.encode(body)
          )
        end

      end
    end
  end
end
