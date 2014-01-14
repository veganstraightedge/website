require 'spec_helper'

describe Provider do
  describe "#from_auth" do
    let!(:auth) { OmniAuth.mock_auth_for(:twitter) }
    let!(:provider) { create(:twitter, uid: auth.uid) }
    it "assigns the handle" do
      expect(Provider.from_auth(auth)).to eq provider
    end
    
    it "updates last_login_at" do
      Provider.from_auth(auth)
      expect(provider.reload.last_login_at).to_not be_blank
    end
    
    it "updates params passed in" do
      Provider.from_auth(auth, ip_address: "127.0.0.1")
      expect(provider.reload.ip_address).to eq "127.0.0.1"
    end
    
    it "assigns the handle" do
      Provider.from_auth(auth)
      expect(provider.reload.handle).to eq "dalecooper"
    end
    
    it "assigns the name if no handle" do
      auth.info.nickname = nil
      Provider.from_auth(auth)
      expect(provider.reload.handle).to eq "dale cooper"
    end
    
  end
end
