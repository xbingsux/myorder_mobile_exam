// import db from "../utils/db";

const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

const testData = async () => {
  try {
    // const data = await prisma.user.findUnique({
    //   include: {
    //       profile: true
    //   },
    //   where: {
    //     email: email,
    //   },
    // });
    // console.log(user);
    data = {"data":"value"}
    return data;
  } catch (err) {
    throw err;
  }
};

const getProfiles = async () => {
  try {
    const profiles = await prisma.profile.findMany({
      // where: {
      //   email: email,
      // },
    });

    return profiles;
  } catch (err) {
    console.log(err);
    throw err;
  }
};

const getProfile = async (id) => {
  try {
    const profile = await prisma.profile.findUnique({
      where: {
        id:parseInt(id),
      },
    });

    return profile;
  } catch (err) {
    console.log(err);
    throw err;
  }
};

const upsertProfile = async (id, email, password, gender, pincode, addr, city, state, country, bank_account_number, account_holder_name, ifsc_code) => {
  
  const toNullIfEmpty = (value) => (value === "" ? null : value);
  id = toNullIfEmpty(id);
  email = toNullIfEmpty(email);
  password = toNullIfEmpty(password);
  gender = toNullIfEmpty(gender);
  pincode = toNullIfEmpty(pincode);
  addr = toNullIfEmpty(addr);
  city = toNullIfEmpty(city);
  state = toNullIfEmpty(state);
  country = toNullIfEmpty(country);
  bank_account_number = toNullIfEmpty(bank_account_number);
  account_holder_name = toNullIfEmpty(account_holder_name);
  ifsc_code = toNullIfEmpty(ifsc_code);



  try {
    if(!id){
      user =findUserByEmail(email)
      if(user != null){
        throw new Error('Email is already in use.');
      }
    }
    const profile = await prisma.profile.upsert({
      where: {
        id: id ? parseInt(id) : 0,

      },
      update: {
        email,
        password,
        gender,
        pincode,
        addr,
        city,
        state,
        country,
        bank_account_number,
        account_holder_name,
        ifsc_code,
      },
      create: {
        email,
        password,
        gender,
        pincode,
        addr,
        city,
        state,
        country,
        bank_account_number,
        account_holder_name,
        ifsc_code,
      },
    });

    return profile;
  } catch (err) {
    console.log(err);
    throw err;
  }
};

const findUserByEmail= async (email) => {
  try {
    const profile = await prisma.profile.findFirst({
      where: {
        email:email,
      },
    });

    return profile;
  } catch (err) {
    console.log(err);
    throw err;
  }
};
const deleteProfile = async (id) => {
  try {
    // const profile = await prisma.profile.findUnique({
    //   where: {
    //     id:parseInt(id),
    //   },
    // });
    const profile =   await prisma.profile.delete({
        where: { id: parseInt(id), }
      });

    return profile;
  } catch (err) {
    console.log(err);
    throw err;
  }
};


module.exports = {
  testData,
  getProfiles,
  getProfile,
  upsertProfile,
  deleteProfile,
  findUserByEmail,
};
