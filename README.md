# case
Aşağıdaki komutlar ile sp'leri oluşturduktan sonra test edebilirsiniz.


EXEC generate_codes_3


Declare @valid int
EXEC check_code_3 '3TC2GDY4', @valid OUTPUT

Select @valid
