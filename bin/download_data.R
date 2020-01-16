if (!dir.exists("data"))
    dir.create("data")

if (! file.exists("data/SAFI_clean.csv")) {
    download.file("https://ndownloader.figshare.com/files/11492171",
                  "data/SAFI_clean.csv", mode = "wb")
}
