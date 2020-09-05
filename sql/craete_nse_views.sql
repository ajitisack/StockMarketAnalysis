drop view if exists symbols;
create view symbols as
    select 
      a.isin
    , a.symbol
    , case when d.symbol is null then 0 else 1 end inhotlist
    , case when b.symbol is null then 0 else 1 end infno
    , case when c.symbol is null then 0 else 1 end innifty50
    , a.name
    , a.facevalue
    , a.series
    , a.dateoflisting
    , a.paidupvalue
    , a.marketlot
    , a.runts
    from NSE_EquitySymbols a
        left outer join NSE_EquityFNOCurrentPrice b on a.symbol = b.symbol
        left outer join NSE_Indices c on a.symbol = c.symbol and c.indexname = 'Nifty 50'
        left outer join NSE_Watchlist d on a.symbol = d.symbol
    where 1 = 1
;

drop view if exists indices;
create view indices as
    select *
    from NSE_Indices
;

drop view if exists histprice;
create view histprice as
    select *
    from NSE_EquityHistoricalPrices
    where 1 = 1
;

/*drop view if exists intradayhist;
create view intradayhist as
    select * from NSE_EquityIntradayPrices_202005 union all
    select * from NSE_EquityIntradayPrices_202006 union all
    select * from NSE_EquityIntradayPrices_202007 union all
    select * from NSE_EquityIntradayPrices_202008*/
;

drop view if exists profilemc;
create view profilemc as
    select *
    from NSE_EquityProfileMoneyControl
    where 1 = 1
;

drop view if exists profileyf;
create view profileyf as
    select *
    from NSE_EquityProfileYahooFinance
    where 1 = 1
;


drop view if exists technicals;
create view technicals as
    select
      date
    , b.innifty50
    , b.infno
    , b.name
    , a.symbol
    , openingtype, openinggap
    , closingtype, closinggap
    , close ltp, prevclose, open, pricechange, pricechangepct
    , low, high
    , pricevolumeratio
    , volume, prevvolume, volumechange, volumechangepct
    , cpr
    , NR4
    , NR7
    , NR9
    , lowerhigh lowerhighthanprevious
    , higherlow higherlowthanprevious
    , r3
    , r2
    , r1
    , bc
    , pp
    , tc
    , s1
    , s2
    , s3
    , a.runts
    from NSE_EquityTechnicals a
        join symbols b on a.symbol = b.symbol
    where 1 = 1
;

drop view if exists pivotpoints;
create view pivotpoints as
    select
      date
    , b.innifty50
    , b.infno
    , b.name
    , a.symbol
    , close ltp
    , r3
    , r2
    , r1
    , bc
    , pp
    , tc
    , cpr
    , s1
    , s2
    , s3
    , a.runts
    from NSE_EquityTechnicals a
        join symbols b on a.symbol = b.symbol
    where 1 = 1
;


drop view if exists narrowrange;
create view narrowrange as
    select
      date
    , b.innifty50
    , b.infno
    , b.name
    , b.symbol
    , close ltp
    , NR4
    , NR7
    , NR9
    , lowerhigh lowerhighthanprevious
    , higherlow higherlowthanprevious
    , tr
    , tr1d
    , tr2d
    , tr3d
    , tr4d
    , tr5d
    , tr6d
    , tr7d
    , tr8d
    , a.runts
    from NSE_EquityTechnicals a
        join symbols b on a.symbol = b.symbol
    where 1 = 1
;

drop view if exists preopen;
create view preopen as
    select 
       time
     , b.name
     , a.symbol
     , b.innifty50
     , b.infno
     , a.openingtype
     , a.prevclose
     , a.open
     , a.pricechange
     , a.pricechangepct
     , a.volume
     , r3
     , r2
     , r1
     , bc
     , pp
     , tc
     , cpr
     , s1
     , s2
     , s3
     , NR4
     , NR7
     , NR9
     , lowerhigh lowerhighthanprevious
     , higherlow higherlowthanprevious
     , yearlow
     , yearhigh
     , sellqty
     , buyqty
     , a.runts
    from NSE_EquityMarketPreOpen a
        join symbols b on a.symbol = b.symbol
        left outer join NSE_EquityTechnicals c on a.symbol = c.symbol
    where 1 = 1
    order by pricechangepct desc
;


drop view if exists fnopreopen;
create view fnopreopen as
    select 
       time
     , b.name
     , a.symbol
     , b.innifty50
     , a.openingtype
     , a.prevclose
     , a.open
     , a.pricechange
     , a.pricechangepct
     , a.volume
     , r3
     , r2
     , r1
     , bc
     , pp
     , tc
     , cpr
     , s1
     , s2
     , s3
     , NR4
     , NR7
     , NR9
     , lowerhigh lowerhighthanprevious
     , higherlow higherlowthanprevious
     , yearlow
     , yearhigh
     , sellqty
     , buyqty
     , a.runts
    from NSE_EquityMarketPreOpen a
        join symbols b on a.symbol = b.symbol
        left outer join NSE_EquityTechnicals c on a.symbol = c.symbol
    where 1 = 1
    and infno = 1
    order by a.pricechangepct desc
;


drop view if exists fnocurrent;
create view fnocurrent as
    select
      a.time
    , b.name
    , a.symbol
    , b.innifty50
    , case when a.pricechange > 0 then 'Up' else 'Down' end trend
    , a.pricechange
    , a.pricechangepct
    , a.lastprice ltp
    , a.open
    , a.low
    , a.high
    , a.volume
    , r3
    , r2
    , r1
    , bc
    , pp
    , tc
    , cpr
    , s1
    , s2
    , s3
    , NR4
    , NR7
    , NR9
    , lowerhigh lowerhighthanprevious
    , higherlow higherlowthanprevious
    , a.runts
    from NSE_EquityFNOCurrentPrice a
        join symbols b on a.symbol = b.symbol
        left outer join NSE_EquityTechnicals c on a.symbol = c.symbol
    order by a.pricechangepct desc
;




