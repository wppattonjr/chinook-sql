/******1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.  ******/
select FirstName, LastName, Country
from Customer c
where country != 'usa'

/******2. Provide a query only showing the Customers from Brazil.  ******/
select FirstName, LastName, Country
from Customer c
where country = 'brazil'

/******3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.  ******/
select c.FirstName, c.LastName, i.InvoiceId, i.BillingCountry, i.InvoiceDate
from Customer c
		join Invoice i
			on i.InvoiceId = c.CustomerId
where c.Country = 'brazil'

/******4. Provide a query showing only the Employees who are Sales Agents.******/
select *
from Employee e
where Title like 'sales support agent'

/******5. Provide a query showing a unique/distinct list of billing countries from the Invoice table. ******/
select distinct BillingCountry
from Invoice i

/******6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name. ******/

/******7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.******/
select i.Total, c.FirstName, c.LastName, c.Country, e.FirstName, e.LastName
from Invoice i
	join Customer c
		on i.CustomerId = c.CustomerId
		join Employee e
			on c.SupportRepId = e.EmployeeId

/******8. How many Invoices were there in 2009 and 2011?******/
select *
from Invoice i
where i.InvoiceDate > '2009-01-01 00:00:00' AND i.InvoiceDate < '2010-01-01 00:00:00'

select *
from Invoice i
where i.InvoiceDate > '2011-01-01 00:00:00' AND i.InvoiceDate < '2012-01-01 00:00:00'

/******9. What are the respective total sales for each of those years?******/
select sum (i.Total) as '2009'
from Invoice i
where i.InvoiceDate > '2009-01-01 00:00:00' AND i.InvoiceDate < '2010-01-01 00:00:00'

select sum (i.Total) as '2011'
from Invoice i
where i.InvoiceDate > '2009-01-01 00:00:00' AND i.InvoiceDate < '2012-01-01 00:00:00'

/******10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.******/
select count(*) as AmountOfItemsForInvoice37
from InvoiceLine
where InvoiceLine.InvoiceId = 37

/******11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY******/
select count(*)
from InvoiceLine il
group by il.InvoiceId

/******12. Provide a query that includes the purchased track name with each invoice line item.******/
select t.Name, il.*
from InvoiceLine il
	join Track t on il.TrackId = t.TrackId

/******13. Provide a query that includes the purchased track name AND artist name with each invoice line item.******/
select t.Name, ar.Name
from InvoiceLine il
	join Track t on il.TrackId = t.TrackId
	join Album a on a.AlbumId = t.AlbumId
	join Artist ar on a.ArtistId = ar.ArtistId
	order by InvoiceLineId

/******14. Provide a query that shows the # of invoices per country. HINT: GROUP BY******/
select Invoice.BillingCountry, count(*) as numberOfInvoices
from Invoice
group by Invoice.BillingCountry

/******15.  Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.******/
select p.Name, count(*) as numberOfTracks
from PlaylistTrack pt
	join Playlist p on p.PlaylistId = pt.PlaylistId
group by p.Name

/******16. Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.******/
select t.name as trackName, a.Title as albumTitle, mt.Name as mediaType, g.Name as Genre
from Track t
	join Album a on a.AlbumId = t.AlbumId
	join Genre g on t.GenreId = g.GenreId
	join MediaType mt on mt.MediaTypeId = t.MediaTypeId
order by albumTitle

/******17. Provide a query that shows all Invoices but includes the # of invoice line items.******/
select *
from Invoice i
	join (select invoiceId, count(*) as numberOfLineItems
	from InvoiceLine il 
	group by InvoiceId) linecount
	on linecount.InvoiceId = i.InvoiceId

/******18. Provide a query that shows total sales made by each sales agent.******/
select e.FirstName, e.LastName, sum(il.Quantity * il.UnitPrice) as totalSales
from InvoiceLine il
	join Invoice i on i.InvoiceId = il.InvoiceId
	join Customer c on i.CustomerId = c.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
group by e.FirstName, e.LastName

/******19.  Which sales agent made the most in sales in 2009? HINT: TOP******/
select top 1 e.FirstName, e.LastName, sum(il.Quantity * il.UnitPrice) as totalSales
from InvoiceLine il
	join Invoice i on il.InvoiceId = i.InvoiceId
	join Customer c on i.CustomerId = c.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
where i.InvoiceDate >= '2009-01-01'
and i.InvoiceDate < '2010-01-01'
group by e.FirstName, e.LastName

/******20. Which sales agent made the most in sales over all?******/
select top 1 e.FirstName, e.LastName, sum(il.UnitPrice * il.Quantity) as totalSales
from InvoiceLine il
	join Invoice i on i.InvoiceId = il.InvoiceId
	join Customer c on i.customerId = c.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
group by e.FirstName, e.LastName

/******21. Provide a query that shows the count of customers assigned to each sales agent.******/
select e.firstName, e.LastName, count(i.CustomerId) as customerCount
from InvoiceLine il
	join Invoice i on il.InvoiceId = i.InvoiceId
	join Customer c on c.CustomerId = i.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
group by e.FirstName, e.LastName

/******22. Provide a query that shows the total sales per country.******/
select c.Country, count(il.InvoiceId) as totalSales
from InvoiceLine il
	join Invoice i on i.invoiceId = il.InvoiceId
	join Customer c on c.customerId = i.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
group by c.Country

/******23. Which country's customers spent the most?******/
select c.Country, sum(il.UnitPrice * il.Quantity) as totalSales
from InvoiceLine il
	join Invoice i on i.InvoiceId = il.InvoiceId
	join Customer c on c.CustomerId = i.CustomerId
	join Employee e on e.EmployeeId = c.SupportRepId
group by c.country 
order by totalSales

/******24. Provide a query that shows the most purchased track of 2013.******/
select count(il.TrackId) as totalPurchased, t.Name
from InvoiceLine il
	join Track t on t.TrackId = il.TrackId
	join Invoice i on i.InvoiceId = il.InvoiceId
where InvoiceDate > '2013-01-01'
and i.InvoiceDate < '2014-01-01'
group by t.Name
order by totalPurchased desc

/******25. Provide a query that shows the top 5 most purchased songs.******/
select top 5 count(il.TrackId) as totalPurchased, t.Name
from InvoiceLine il
	join Track t on t.TrackId = il.TrackId
	join Invoice i on i.InvoiceId = il.InvoiceId
group by t.Name
order by totalPurchased desc

/******26. Provide a query that shows the top 3 best selling artists.******/
select top 3 count(il.TrackId)as totalPurchased, ar.Name
from InvoiceLine il
	join Invoice i on i.InvoiceId = il.InvoiceId
	join Track t on t.TrackId = il.TrackId
	join Album a on a.AlbumId = t.AlbumId
	join Artist ar on ar.ArtistId = a.ArtistId
group by ar.Name
order by totalPurchased desc

/******27. Provide a query that shows the most purchased Media Type.******/
select top 1 count(il.TrackId) as totalPurchased, mt.Name
from InvoiceLine il
	join Invoice i on i.InvoiceId = il.InvoiceId
	join Track t on t.TrackId = il.TrackId
	join MediaType mt on mt.MediaTypeId = t.MediaTypeId
group by mt.Name
order by totalPurchased desc