-- helper to find elements by its values
local function _indexOf (target, field)
	if type(target) == 'string' then
		return target:find(field, 1, true)
	end

	for index, value in pairs(target) do
		if value == field then return index end
	end

	return nil
end

-- list of supported methods to override
local function _supportMethod (method)
	local methods = {
		'get',
		'post',
		'put',
		'head',
		'delete',
		'options',
		'trace',
		'copy',
		'lock',
		'mkcol',
		'move',
		'propfind',
		'proppatch',
		'unlock',
		'report',
		'mkactivity',
		'checkout',
		'merge',
		'm-search',
		'notify',
		'subscribe',
		'unsubscribe',
		'patch'
	}

	return _indexOf(methods, method) ~= nil
end

-- provides faux http method support
-- pass optional key param to use when checking for a method override, defaults to '_method'
local function methodOverride (key)
	key = key or '_method'

	return function (req, res, follow)
		req.originalMethod = req.originalMethod or req.method

		local method

		if req.body and type(req.body) == 'table' and req.body[key] ~= nil then
			method = req.body[key]:lower()
			req.body[key] = nil
		end

		if req.headers['x-http-method-override'] then
			method = req.headers['x-http-method-override']:lower()
		end

		if _supportMethod(method) then
			req.method = method:upper()
		end

		follow()
	end
end

return methodOverride
