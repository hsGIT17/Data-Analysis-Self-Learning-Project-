import pandas as pd

file_path = 'netflix_data.csv'
df = pd.read_csv(file_path)

with open('insert_netflix_data.sql', 'w') as f:
    # Write the table creation statement
    f.write('CREATE TABLE netflix_data (\n')
    f.write('    show_id TEXT,\n')
    f.write('    type TEXT,\n')
    f.write('    title TEXT,\n')
    f.write('    director TEXT,\n')
    f.write('    cast TEXT,\n')
    f.write('    country TEXT,\n')
    f.write('    date_added TEXT,\n')
    f.write('    release_year INTEGER,\n')
    f.write('    rating TEXT,\n')
    f.write('    duration TEXT,\n')
    f.write('    listed_in TEXT,\n')
    f.write('    description TEXT\n')
    f.write(');\n\n')
    
    for index, row in df.iterrows():
        f.write(f"INSERT INTO netflix_data (show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description) VALUES (")
        f.write(f"'{row['show_id']}', '{row['type']}', '{row['title'].replace("'", "''")}', '{row['director'].replace("'", "''")}', '{row['cast'].replace("'", "''")}', ")
        f.write(f"'{row['country'].replace("'", "''")}', '{row['date_added'].replace("'", "''")}', {row['release_year']}, '{row['rating']}', '{row['duration']}', ")
        f.write(f"'{row['listed_in'].replace("'", "''")}', '{row['description'].replace("'", "''")}');\n")

print("Completed")
