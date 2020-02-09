use std::error::Error;

use lambda_runtime::{error::HandlerError, lambda, Context};
use log::{self, error};
use serde_derive::{Deserialize, Serialize};
use simple_logger;

#[derive(Deserialize)]
struct Nada {}

#[derive(Deserialize)]
struct CustomEvent {
    #[serde(rename = "firstName")]
    first_name: String,
}

#[derive(Serialize)]
struct CustomOutput {
    message: String,
}

fn main() -> Result<(), Box<dyn Error>> {
    simple_logger::init_with_level(log::Level::Debug)?;
    lambda!(my_handler);

    Ok(())
}

fn my_handler(e: Nada, c: Context) -> Result<CustomOutput, HandlerError> {
    // if e.first_name == "" {
    //     error!("Empty first name in request {}", c.aws_request_id);
    //     Err(HandlerError::from("Empty first name!"))
    // } else {
    //     Ok(CustomOutput {
    //         message: format!("Hello, {}!", e.first_name),
    //     })
    // }
    Ok(CustomOutput {
        message: format!("Oi, mundo!"),
    })
}
