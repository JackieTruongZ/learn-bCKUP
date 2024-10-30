interface user {
    name: string;
    accessable: {
        name: boolean,
        age: boolean
    }
}

const userFind: user = {
    name: 'jack',
    accessable: {
        name: true,
        age: true,
    }
}

const userChange = {
    name: 'jack',
    accessable: {
        name: false,
    }
}

if ((userChange as any).accessable) {
    const updatedUser = {
        ...userFind,
        accessable: {
            ...userFind.accessable,
            ...userChange.accessable
        }
    };
    console.log("user : ", updatedUser);

}

// const updatedData = { ...userFind, ...userChange };

// console.log("user : ", updatedData);
