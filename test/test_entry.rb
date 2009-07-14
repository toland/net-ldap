require 'common'

class TestEntry < Test::Unit::TestCase

	context "An instance of Entry" do

		setup do
			@entry = Net::LDAP::Entry.new 'cn=Barbara,o=corp'
		end

		should "be initialized with the DN" do
			assert_equal 'cn=Barbara,o=corp', @entry.dn
		end

		should 'return an empty array when accessing a nonexistent attribute (index lookup)' do
			assert_equal [], @entry['sn']
		end

		should 'return an empty array when accessing a nonexistent attribute (method call)' do
			assert_equal [], @entry.sn
		end

		should 'create an attribute on assignment (index lookup)' do
			@entry['sn'] = 'Jensen'
			assert_equal ['Jensen'], @entry['sn']
		end

		should 'create an attribute on assignment (method call)' do
			@entry.sn = 'Jensen'
			assert_equal ['Jensen'], @entry.sn
		end

		should 'have attributes accessible by index lookup' do
			@entry['sn'] = 'Jensen'
			assert_equal ['Jensen'], @entry['sn']
		end

		should 'have attributes accessible using a Symbol as the index' do
			@entry[:sn] = 'Jensen'
			assert_equal ['Jensen'], @entry[:sn]
		end

		should 'have attributes accessible by method call' do
			@entry['sn'] = 'Jensen'
			assert_equal ['Jensen'], @entry.sn
		end

		should 'have attributes which are appendable using <<' do
			@entry['sn'] << 'Jensen'
			@entry['sn'] << 'Johnson'
			assert_equal %w(Jensen Johnson), @entry['sn']
		end

		should 'ignore case of attribute names' do
			@entry['sn'] = 'Jensen'
			assert_equal ['Jensen'], @entry.sn
			assert_equal ['Jensen'], @entry.Sn
			assert_equal ['Jensen'], @entry.SN
			assert_equal ['Jensen'], @entry['sn']
			assert_equal ['Jensen'], @entry['Sn']
			assert_equal ['Jensen'], @entry['SN']
		end

		should 'be capable of being (un)marshaled' do
			@entry['sn'] << 'Jensen'
			@entry['sn'] << 'Johnson'

			entry_dump = Marshal.dump(@entry)
			entry_load = Marshal.load(entry_dump)

			assert_equal(@entry, entry_load)
		end
	end
end
