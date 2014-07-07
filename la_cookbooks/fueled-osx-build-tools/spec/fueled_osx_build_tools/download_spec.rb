require 'rspec'
require_relative '../../libraries/fueled_osx_build_tools/download'

describe FueledOsxBuildTools::Download do
  it 'retrieves a valid download link for os x mavericks' do
    download = FueledOsxBuildTools::Download.new(
      ENV['fueled_apple_id'],
      ENV['fueled_apple_password']
    )

    expect(download.sign_in).to be(true)
    expect(download.retrieve).to be(true)
  end
end
