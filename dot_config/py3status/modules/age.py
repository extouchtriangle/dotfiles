class Py3status:
    def display(self):
        import datetime
        date_time = datetime.datetime.now()
        year = int(date_time[0:4])
        month = int(date_time[5:7])-1 # indexing purposes
        day =
