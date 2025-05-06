CREATE PROCEDURE [dbo].[check_code]
    @PromoCode NVARCHAR(8),
    @IsValid INT OUTPUT
AS
BEGIN
    DECLARE @ValidChars NVARCHAR(23) = 'ACDEFGHKLMNPRTXYZ234579';
    DECLARE @DigitIndex INT = 1;
    DECLARE @HashSeed INT = 0;
    DECLARE @PickIndex INT;
    DECLARE @ExpectedControlChar CHAR(1);
    DECLARE @ActualControlChar CHAR(1);
    DECLARE @CharPoolSize INT = 23;

    IF LEN(@PromoCode) <> 8
    BEGIN
        SET @IsValid = 0;
        RETURN;
    END

    WHILE @DigitIndex <= 7
    BEGIN
        SET @PickIndex = CHARINDEX(SUBSTRING(@PromoCode, @DigitIndex, 1), @ValidChars) - 1;
        IF @PickIndex < 0
        BEGIN
            SET @IsValid = 0;
            RETURN;
        END

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

    SET @ExpectedControlChar = SUBSTRING(@ValidChars, @HashSeed + 1, 1)
    SET @ActualControlChar = SUBSTRING(@PromoCode, 8, 1)

    IF @ExpectedControlChar = @ActualControlChar
        SET @IsValid = 1
    ELSE
        SET @IsValid = 0
END
GO

