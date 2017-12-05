"use strict"

angular.module "app.services"

.factory "UtilService", ->

	utilService =
		date:
			datenumToDate: (datenum) ->
				date = new Date()
				date.setTime(datenum)
				date
			padZero: (s) ->
				if s.length is 1 then "0" + s else s
			dateToString: (date) ->
				str = null
				if date?
					if date not instanceof Date
						date = new Date date
					m = utilService.date.padZero (date.getMonth() + 1).toString()
					d = utilService.date.padZero date.getDate().toString()
					y = date.getFullYear().toString()
					H = utilService.date.padZero date.getHours().toString()
					M = utilService.date.padZero date.getMinutes().toString()
					S = utilService.date.padZero date.getSeconds().toString()
					str = m + "/" + d + "/" + y + " " + H + ":" + M + ":" + S
				str
			isDateString: (dateStr) ->
				dateStr? and typeof dateStr is "string" and dateStr.match /^[0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$/

	utilService
