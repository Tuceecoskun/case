USE [EGITIM]
GO

/****** Object:  StoredProcedure [dbo].[generate_codes]    Script Date: 5/6/2025 7:29:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[generate_codes]
AS
BEGIN
DECLARE @ValidChars NVARCHAR(23) = 'ACDEFGHKLMNPRTXYZ234579';
DECLARE @CharPoolSize INT = 23;
DECLARE @DigitIndex INT;
DECLARE @PromoCode NVARCHAR(8);
DECLARE @HashSeed INT;
DECLARE @PickIndex INT;
DECLARE @ControlChar CHAR(1);
DECLARE @LoopCounter INT = 1;

WHILE @LoopCounter <= 1000
BEGIN
    SET @DigitIndex = 1;
    SET @PromoCode = '';
    SET @HashSeed = 0;

    WHILE @DigitIndex <= 7
    BEGIN
        SET @PickIndex = CAST(RAND(CHECKSUM(NEWID())) * @CharPoolSize AS INT);
        SET @PromoCode = @PromoCode + SUBSTRING(@ValidChars, @PickIndex + 1, 1);

        SET @HashSeed = @HashSeed + (@PickIndex * CASE @DigitIndex
                                        WHEN 1 THEN 3
                                        WHEN 2 THEN 5
                                        WHEN 3 THEN 7
                                        WHEN 4 THEN 9
                                        WHEN 5 THEN 11
                                        WHEN 6 THEN 13
                                        WHEN 7 THEN 17
                                    END)

        SET @DigitIndex = @DigitIndex + 1;
    END

    WHILE @HashSeed >= @CharPoolSize
    BEGIN
        SET @HashSeed = @HashSeed - @CharPoolSize
    END

    SET @ControlChar = SUBSTRING(@ValidChars, @HashSeed + 1, 1)
    SET @PromoCode = @PromoCode + @ControlChar

    PRINT @PromoCode

    SET @LoopCounter = @LoopCounter + 1;
END

END
GO

