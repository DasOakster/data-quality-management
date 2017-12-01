Attribute VB_Name = "GoogleProductFeed"
Option Explicit

Sub SubsetColumns()

Dim SourceColumn As Range
Dim TargetColumn As Range
Dim ws As Worksheet

Set ws = ThisWorkbook.Sheets.Add(After:=ThisWorkbook.Sheets(ThisWorkbook.Sheets.Count))

ws.Name = "Google Feed"


Worksheets("productfeed").Select

Application.Union(Columns(1), Columns(3), Columns(18), Columns(21), Columns(25), Columns(26), Columns(27), Columns(28), Columns(29), Columns(30), Columns(31), Columns(32), Columns(33), Columns(34), Columns(35), Columns(36), Columns(37), Columns(38), Columns(39), Columns(40), Columns(41), Columns(42), Columns(45), Columns(46)).Select

Set SourceColumn = Selection

Set TargetColumn = Worksheets("Google Feed").Columns("A")

SourceColumn.Copy Destination:=TargetColumn


End Sub
