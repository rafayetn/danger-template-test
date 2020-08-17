require 'rails_helper'

describe 'Codebase', codebase: true do
  it 'does not offend Rubocop' do
    expect(`rubocop --format simple`).to include 'no offenses detected'
  end

  it 'satisfies Brakeman' do
    expect(`brakeman -w2`).not_to include '+SECURITY WARNINGS+'
  end

  it 'does NOT break zeitwerk loading' do
    expect(`bundle exec rake zeitwerk:check`).to include 'All is good!'
  end

  context 'respond_to blocks' do
    it 'does not contain respond_to blocks' do
      find_results = `grep -r 'respond_to do' app/`
      expect(find_results).to be_empty
    end

    it 'does not contain format blocks' do
      find_results = `grep -r 'format.json' app/`
      expect(find_results).to be_empty
    end
  end

  it 'does not offend scss-lint' do
    expect(`scss-lint`).to be_empty
  end

  it 'does not offend eslint' do
    expect(`yarn run eslint ./`).to include 'Done'
  end
end
