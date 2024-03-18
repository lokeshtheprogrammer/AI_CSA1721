student(Name, RegNo).
teacher(Name, SubjectCode).
enrolled(RegNo, SubjectCode).

% Example data (replace with your actual data)
student('Alice', 123).
student('Bob', 456).
teacher('Mr. Green', 'CS101').
teacher('Ms. Brown', 'MATH202').
enrolled(123, 'CS101').
enrolled(123, 'MATH202').
enrolled(456, 'CS101').

