create procedure usp_GetOrderTrackingForCustomer
	@StoreName varchar(50),
	@TrackingNumber varchar(25) output
as
begin
	-- Declaring Variables
	declare @SalesOrderID int;

	-- Get latest sales order header
	select top 1 @SalesOrderID = SOH.SalesOrderID
	from Sales.SalesOrderHeader SOH
		inner join Sales.Customer c on SOH.CustomerID = c.CustomerID
		inner join Sales.Store s on c.StoreID = s.BusinessEntityID
	where s.Name = @StoreName
	order by SOH.OrderDate desc

	if @@ROWCOUNT > 0 
	begin
		-- Get tracking number -- last tracking entry for sales order
		select top 1 @TrackingNumber = isnull(SOD.CarrierTrackingNUmber, 'No tracking number for store')
		from Sales.SalesOrderDetail SOD
		where SOD.SalesOrderID = @SalesOrderID
	end
	else
	begin
	set @TrackingNumber = 'Store not found'
	end
end


-- Test Cases
-- Testing
----------------------------
declare @name varchar(25)
declare @trackingInfo varchar(50)
----------------------------

-- Test 1
set @name = 'Good Toys'
set @trackingInfo = null
execute usp_GetOrderTrackingForCustomer @name, @trackingInfo output
select 'Test 1', @trackingInfo

-- Test 2
set @name = 'Broken Toys'
set @trackingInfo = null
execute usp_GetOrderTrackingForCustomer @name, @trackingInfo output
select 'Test 2', @trackingInfo

-- Test 3
set @name = 'The Bike Mechanics'
set @trackingInfo = null
execute usp_GetOrderTrackingForCustomer @name, @trackingInfo output
select 'Test 3', @trackingInfo
