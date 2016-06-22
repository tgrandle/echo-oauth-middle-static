require 'sinatra'
require 'json'
require 'pp'

enable :sessions

get '/' do
	'hello world'
end

get '/login' do
	puts "starting get /login"

	puts "**************** "
	pp params
	state = params['state']
	session['state'] = state
	puts "**************** state: #{state}"

	client_id = params['client_id']
	session['client_id'] = client_id
	puts "**************** client_id: #{client_id}"

	response_type = params['response_type']
	session['response_type'] = response_type
	puts "**************** response_type: #{response_type}"

	erb :index
end

post '/login' do
	puts "starting post /login"

	pp params
	id = params['StringName']

	puts "successful login for #{id}"

	accessToken = '2YotnFZFEjr1zCsicMWpAA'
	state = session[:state]
	client_id = session[:client_id]

	# redirect_url = "https://pitangui.amazon.com/spa/skill/account-linking-status.html"\
	# 	"?vendorId=M3EN22YAFPA9R9"\
	# 	"&token_type=Bearer"\
	# 	"&access_token=#{accessToken}"\
	# 	"&client_id=#{client_id}"\
	# 	"&state=#{state}"

	redirect_url = "https://pitangui.amazon.com/spa/skill/account-linking-status.html"\
		"?vendorId=M3EN22YAFPA9R9"\
		"#state=#{state}"\
		"&token_type=Bearer"\
		"&access_token=#{accessToken}"\
		"&client_id=#{client_id}"

	puts "redirecting to #{redirect_url}"
	redirect to (redirect_url)
end

get '/privacy' do
	'this is the privacy policy'
end

get '/balance' do
	'{"GetAccountSummaryDetailsResponse":{"GetCCAccountNumberResponseBody":{"Current_Balance":"100", "Next_Payment_Due_Date":"now"}}}'
end

get '/test' do
	'{"GetAccountSummaryDetailsResponse":{"GetCCAccountNumberResponseBody":{"Current_Balance":"100", "Next_Payment_Due_Date":"now"}}}'
end