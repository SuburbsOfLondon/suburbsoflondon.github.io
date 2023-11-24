//probs wont bother with this

function findImages(folderPath) {
    // Read the contents of the folder
    const files = fs.readdirSync(folderPath);

    // Filter out only the image files (you can add more file extensions if needed)
    const imageFiles = files.filter(file => {
        const ext = path.extname(file).toLowerCase();
        return ['.jpg', '.jpeg', '.png', '.gif'].includes(ext);
    });

    return imageFiles;
}

function findRollFolders(folderPath){

}